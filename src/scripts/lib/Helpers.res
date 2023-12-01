type error = [
  | #failedToUploadFile
  | #fileNotExist
  | #noEnoughRAM
  | #failedToExecScript
  | #invalidThreads
]

/** Crawls all servers and returns the set of servers.

 If `excludePurchasedServers` is true then returns servers excluding purchased servers.

 If `excludeHome` is false then the returned set contains the `home` server.
 */
let crawlServers = (ns, ~excludePurchasedServers=false, ~excludeHome=true) => {
  let servers = Set.make()

  let rec getServers = (server, remains) =>
    if servers->Set.has(server) {
      switch (remains->Set.values->Iterator.next).value {
      | Some(s) => {
          remains->Set.delete(s)->ignore
          getServers(s, remains)
        }
      | None => ()
      }
    } else {
      servers->Set.add(server)
      ns->NS.scan(~host=server)->Array.forEach(s => remains->Set.add(s))
      getServers(server, remains)
    }
  getServers(ns->NS.getHostname, Set.make())

  if excludePurchasedServers {
    ns->NS.getPurchasedServers->Array.forEach(s => servers->Set.delete(s)->ignore)
  }

  if excludeHome {
    servers->Set.delete("home")->ignore
  }

  servers
}

/** Gets root access on target server.

 Returns whether gets the root access.
 */
let getRootAccess = (ns, host) => {
  let info = ns->NS.getServer(~host)
  if info.hasAdminRights {
    true
  } else {
    switch (info.openPortCount, info.numOpenPortsRequired) {
    | (Some(openPortCount), Some(numOpenPortsRequired)) => {
        if openPortCount < numOpenPortsRequired {
          if !info.sshPortOpen && ns->NS.fileExists("BruteSSH.exe", ~host="home") {
            ns->NS.brutessh(host)
          }

          let info = ns->NS.getServer(~host)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.ftpPortOpen &&
            ns->NS.fileExists("FTPCrack.exe", ~host="home")
          ) {
            ns->NS.ftpcrack(host)
          }

          let info = ns->NS.getServer(~host)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.smtpPortOpen &&
            ns->NS.fileExists("relaySMTP.exe", ~host="home")
          ) {
            ns->NS.relaysmtp(host)
          }

          let info = ns->NS.getServer(~host)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.httpPortOpen &&
            ns->NS.fileExists("HTTPWorm.exe", ~host="home")
          ) {
            ns->NS.httpworm(host)
          }

          let info = ns->NS.getServer(~host)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.sqlPortOpen &&
            ns->NS.fileExists("SQLInject.exe", ~host="home")
          ) {
            ns->NS.sqlinject(host)
          }
        }

        let info = ns->NS.getServer(~host)
        if info.openPortCount->Option.getUnsafe >= info.numOpenPortsRequired->Option.getUnsafe {
          if ns->NS.fileExists("NUKE.exe", ~host="home") {
            ns->NS.nuke(host)

            let info = ns->NS.getServer(~host)
            if info.hasAdminRights {
              true
            } else {
              ns->NS.print(`ERROR: failed to get root access on server ${host}`)

              false
            }
          } else {
            ns->NS.print("ERROR: no NUKE.exe on home server")

            false
          }
        } else {
          false
        }
      }
    | _ => false
    }
  }
}

let uploadFile = (ns, server, file) =>
  if ns->NS.fileExists(file) {
    if ns->NS.scp(file, server) {
      true
    } else {
      ns->NS.print(`ERROR: failed to upload file ${file} to server ${server}`)

      false
    }
  } else {
    ns->NS.print(`ERROR: file ${file} does not exist on current server ${ns->NS.getHostname}`)

    false
  }

let execScript = (ns, server, script, ~threads=?, ~upload=true, ~args=?) => {
  let upload = if server === ns->NS.getHostname {
    false
  } else {
    upload
  }
  let args = args->Option.getOr([])->Array.map(arg => NSTypes.StringArg(arg))

  if upload && !(ns->uploadFile(server, script)) {
    Error(#failedToUploadFile)
  } else {
    let scriptRAM = ns->NS.getScriptRam(script, ~host=server)

    if scriptRAM > 0.0 {
      let exec = threads =>
        if threads >= 1 {
          let pid = ns->NS.exec(script, server, ~threads, ~args)
          if pid !== 0 {
            Ok((pid, threads, scriptRAM *. threads->Int.toFloat))
          } else {
            Error(#failedToExecScript)
          }
        } else {
          Error(#invalidThreads)
        }

      switch threads {
      | Some(threads) => exec(threads)
      | None => {
          let ram = ns->NS.getServerMaxRam(server) -. ns->NS.getServerUsedRam(server)
          if ram > 0.0 && ram >= scriptRAM {
            exec((ram /. scriptRAM)->Js.Math.floor_int)
          } else {
            Error(#noEnoughRAM)
          }
        }
      }
    } else {
      Error(#fileNotExist)
    }
  }
}
