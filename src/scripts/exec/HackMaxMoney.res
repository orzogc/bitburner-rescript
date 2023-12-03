open NSTypes

type action = Weaken | Grow | Hack

type scriptInfo = {target: host}

type serverInfo = {
  host: host,
  cores: cores,
  maxRam: ram,
  usedRam: ram,
  availableRam: ram,
}

type targetInfo = {
  host: host,
  minSecurity: securityLevel,
  security: securityLevel,
  maxMoney: money,
  money: money,
}

type taskInfo = {
  action: action,
  target: host,
}

let weakenScript = "/scripts/exec/WeakenOnce.res.js"
let growScript = "/scripts/exec/GrowOnce.res.js"
let hackScript = "/scripts/exec/HackOnce.res.js"

let schema = {
  "includePurchasedServers": false,
  "includeHome": false,
  "help": false,
}

let homeLeastFreeRAM = 32.0

let coresNum: array<cores> = []

let servers: Map.t<cores, array<serverInfo>> = Map.make()

let targets: Map.t<host, targetInfo> = Map.make()

let scripts: Map.t<pid, scriptInfo> = Map.make()

let todoTasks: array<taskInfo> = []

let actionToString = action =>
  switch action {
  | Weaken => "weaken"
  | Grow => "grow"
  | Hack => "hack"
  }

let clearServers = () => {
  coresNum->Array.splice(~start=0, ~remove=coresNum->Array.length, ~insert=[])
  servers->Map.clear
}

let updateServers = (info: server) => {
  if info.hasAdminRights && info.maxRam > 0.0 {
    if !(coresNum->Array.some(cores => cores === info.cpuCores)) {
      coresNum->Array.push(info.cpuCores)
    }

    let serverInfo = {
      host: info.hostname,
      cores: info.cpuCores,
      maxRam: info.maxRam,
      usedRam: info.ramUsed,
      availableRam: info.maxRam -. info.ramUsed,
    }
    switch servers->Map.get(info.cpuCores) {
    | Some(array) => array->Array.push(serverInfo)
    | None => servers->Map.set(info.cpuCores, [serverInfo])
    }
  }
}

let sortServers = () => {
  coresNum->Array.sort((a, b) =>
    if a < b {
      Ordering.greater
    } else if a > b {
      Ordering.less
    } else {
      Ordering.equal
    }
  )

  servers->Map.forEachWithKey((serverList, cores) => {
    serverList->Array.sort((a, b) =>
      if a.availableRam < b.availableRam {
        Ordering.greater
      } else if a.availableRam > b.availableRam {
        Ordering.less
      } else {
        Ordering.equal
      }
    )
    servers->Map.set(cores, serverList)
  })
}

let updateTargets = (ns, info: server) =>
  switch (
    info.requiredHackingSkill,
    info.minDifficulty,
    info.hackDifficulty,
    info.moneyMax,
    info.moneyAvailable,
  ) {
  | (Some(hacking), Some(minSecurity), Some(security), Some(maxMoney), Some(money)) =>
    if info.hasAdminRights && ns->NS.getHackingLevel / 2 >= hacking && maxMoney > 0.0 {
      if (
        !(targets->Map.has(info.hostname)) &&
        !(scripts->Map.values->Iterator.toArray->Array.some(t => t.target === info.hostname)) &&
        !(todoTasks->Array.some(t => t.target === info.hostname))
      ) {
        todoTasks->Array.push({action: Weaken, target: info.hostname})
      }

      targets->Map.set(
        info.hostname,
        {
          host: info.hostname,
          minSecurity,
          security,
          maxMoney,
          money,
        },
      )
    }
  | _ => ()
  }

let updateTasks = ns => {
  let running: Set.t<host> = Set.make()
  let deleted: Set.t<host> = Set.make()
  scripts->Map.forEachWithKey((script, pid) => {
    if ns->NS.isRunningByPID(pid) {
      running->Set.add(script.target)
    } else {
      scripts->Map.delete(pid)->ignore
      deleted->Set.add(script.target)
    }
  })

  deleted->Set.forEach(target =>
    if !(running->Set.has(target)) {
      switch targets->Map.get(target) {
      | Some(info) =>
        if info.security > info.minSecurity {
          todoTasks->Array.push({action: Weaken, target})
        } else if info.money < info.maxMoney {
          todoTasks->Array.push({action: Grow, target})
        } else {
          todoTasks->Array.push({action: Hack, target})
        }
      | None => ns->NS.print(`ERROR: no target ${target} in targets`)
      }
    }
  )
}

let sortTodoTasksExn = () =>
  todoTasks->Array.sort((a, b) => {
    let info1 = targets->Map.get(a.target)->Option.getExn
    let info2 = targets->Map.get(b.target)->Option.getExn

    if info1.maxMoney < info2.maxMoney {
      Ordering.greater
    } else if info1.maxMoney > info2.maxMoney {
      Ordering.less
    } else {
      Ordering.equal
    }
  })

let runTaskExn = ns => {
  let weakenScriptRam = if ns->NS.fileExists(weakenScript) {
    ns->NS.getScriptRam(weakenScript)
  } else {
    failwith("no weaken script")
  }
  let growScriptRam = if ns->NS.fileExists(growScript) {
    ns->NS.getScriptRam(growScript)
  } else {
    failwith("no grow script")
  }
  let hackScriptRam = if ns->NS.fileExists(hackScript) {
    ns->NS.getScriptRam(hackScript)
  } else {
    failwith("no hack script")
  }

  let availableRam: Map.t<host, ram> = Map.make()
  servers->Map.forEach(serverList =>
    serverList->Array.forEach(server => {
      let ram = if server.host === "home" {
        Math.max(server.availableRam -. homeLeastFreeRAM, 0.0)
      } else {
        server.availableRam
      }

      availableRam->Map.set(server.host, ram)
    })
  )
  let tasks = Set.fromArray(todoTasks)

  tasks->Set.forEach(task => {
    let allThreads = ref(0)

    let rec runCores = (coresList, coresIndex, f) =>
      switch coresList[coresIndex] {
      | Some(cores) =>
        if !f(cores) {
          runCores(coresList, coresIndex + 1, f)
        }
      | None =>
        ns->NS.print(`INFO: no servers to ${task.action->actionToString} server ${task.target}`)
      }

    let rec runServers = (cores, serverIndex, script, scriptRAM, getThreads) =>
      switch servers->Map.get(cores) {
      | Some(serverList) =>
        switch serverList[serverIndex] {
        | Some(server) => {
            let ram = availableRam->Map.get(server.host)->Option.getExn

            if ram >= scriptRAM {
              switch getThreads(task.target, server.cores) {
              | Ok(t) => {
                  let threads = t - allThreads.contents
                  let threads = if threads === 0 {
                    1
                  } else {
                    threads
                  }
                  if threads > 0 {
                    let fullThreads = (ram /. scriptRAM)->Js.Math.floor_int

                    let exec = threads =>
                      switch ns->Helpers.execScript(
                        server.host,
                        script,
                        ~threads,
                        ~upload=true,
                        ~args=[task.target],
                      ) {
                      | Ok((pid, t, r)) => {
                          scripts->Map.set(pid, {target: task.target})
                          tasks->Set.delete(task)->ignore
                          allThreads := allThreads.contents + t
                          availableRam->Map.set(server.host, Math.max(ram -. r, 0.0))

                          true
                        }
                      | Error(e) => {
                          ns->NS.print2(
                            `ERROR: failed to exec script ${script} on server ${server.host}`,
                            e,
                          )

                          false
                        }
                      }

                    if fullThreads >= threads {
                      if exec(threads) {
                        true
                      } else {
                        runServers(cores, serverIndex + 1, script, scriptRAM, getThreads)
                      }
                    } else {
                      exec(fullThreads)->ignore

                      runServers(cores, serverIndex + 1, script, scriptRAM, getThreads)
                    }
                  } else {
                    ns->NS.print(`INFO: threads ${threads->Int.toString} is less than 1`)

                    true
                  }
                }
              | Error(e) => {
                  ns->NS.print2("ERROR: ", e)

                  runServers(cores, serverIndex + 1, script, scriptRAM, getThreads)
                }
              }
            } else {
              runServers(cores, serverIndex + 1, script, scriptRAM, getThreads)
            }
          }
        | None => false
        }
      | None => {
          ns->NS.print(`ERROR: no cores ${cores->Int.toString} in servers`)

          false
        }
      }

    switch task.action {
    | Weaken => {
        ns->NS.print(`INFO: start weaken server ${task.target}`)

        runCores(coresNum, 0, cores =>
          runServers(
            cores,
            0,
            weakenScript,
            weakenScriptRam,
            (host, cores) => ns->Server.weakenThreads(host, cores),
          )
        )
      }
    | Grow => {
        ns->NS.print(`INFO: start to grow server ${task.target}`)
        runCores(coresNum, 0, cores =>
          runServers(
            cores,
            0,
            growScript,
            growScriptRam,
            (host, cores) => ns->Server.growThreads(host, cores),
          )
        )
      }
    | Hack => {
        ns->NS.print(`INFO: start to hack server ${task.target}`)
        runCores(coresNum->Array.toReversed, 0, cores =>
          runServers(cores, 0, hackScript, hackScriptRam, (host, _) => ns->Server.hackThreads(host))
        )
      }
    }
  })

  todoTasks->Array.splice(
    ~start=0,
    ~remove=todoTasks->Array.length,
    ~insert=tasks->Set.values->Iterator.toArray,
  )
}

let main: NS.main = async ns => {
  let (flags, _) = ns->Flags.getFlagsExn(schema)

  if flags["help"] {
    ns->NS.tprint("Hacks max money from servers.
--includePurchasedServers : Includes purchased servers.
--includeHome : Includes home server.")
  } else {
    ns->NS.disableLog("getHackingLevel")
    ns->NS.disableLog("scan")
    ns->NS.disableLog("scp")

    while true {
      let allServers =
        ns->Helpers.crawlServers(
          ~excludePurchasedServers=!flags["includePurchasedServers"],
          ~excludeHome=!flags["includeHome"],
        )
      clearServers()
      allServers->Set.forEach(server => {
        ns->Helpers.getRootAccess(server)->ignore
        let info = ns->NS.getServer(~host=server)
        info->updateServers
        ns->updateTargets(info)
      })
      sortServers()
      ns->updateTasks
      sortTodoTasksExn()
      ns->runTaskExn

      (await ns->NS.asleep(5000.0))->ignore
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  if !(args->Flags.argsToStrings->Flags.argsHasHelp) {
    Flags.schemaToFlagsExn(data.flags, schema)->ignore
  }

  []
}
