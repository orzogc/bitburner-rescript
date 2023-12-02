@scope("Number") @val
external isInteger: float => bool = "isInteger"

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
let getRootAccess = (ns, target) => {
  let info = ns->NS.getServer(~host=target)
  if info.hasAdminRights {
    true
  } else {
    switch (info.openPortCount, info.numOpenPortsRequired) {
    | (Some(openPortCount), Some(numOpenPortsRequired)) => {
        if openPortCount < numOpenPortsRequired {
          if !info.sshPortOpen && ns->NS.fileExists("BruteSSH.exe", ~host="home") {
            ns->NS.brutessh(target)
          }

          let info = ns->NS.getServer(~host=target)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.ftpPortOpen &&
            ns->NS.fileExists("FTPCrack.exe", ~host="home")
          ) {
            ns->NS.ftpcrack(target)
          }

          let info = ns->NS.getServer(~host=target)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.smtpPortOpen &&
            ns->NS.fileExists("relaySMTP.exe", ~host="home")
          ) {
            ns->NS.relaysmtp(target)
          }

          let info = ns->NS.getServer(~host=target)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.httpPortOpen &&
            ns->NS.fileExists("HTTPWorm.exe", ~host="home")
          ) {
            ns->NS.httpworm(target)
          }

          let info = ns->NS.getServer(~host=target)
          if (
            info.openPortCount->Option.getUnsafe < info.numOpenPortsRequired->Option.getUnsafe &&
            !info.sqlPortOpen &&
            ns->NS.fileExists("SQLInject.exe", ~host="home")
          ) {
            ns->NS.sqlinject(target)
          }
        }

        let info = ns->NS.getServer(~host=target)
        if info.openPortCount->Option.getUnsafe >= info.numOpenPortsRequired->Option.getUnsafe {
          if ns->NS.fileExists("NUKE.exe", ~host="home") {
            ns->NS.nuke(target)

            let info = ns->NS.getServer(~host=target)
            if info.hasAdminRights {
              true
            } else {
              ns->NS.print(`ERROR: failed to get root access on server ${target}`)

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

let uploadFile = (ns, target, file) =>
  if ns->NS.fileExists(file) {
    if target === ns->NS.getHostname || ns->NS.scp(file, target) {
      true
    } else {
      ns->NS.print(`ERROR: failed to upload file ${file} to server ${target}`)

      false
    }
  } else {
    ns->NS.print(`ERROR: file ${file} does not exist on current server ${ns->NS.getHostname}`)

    false
  }

type execScriptError = [
  | #failedToUploadFile
  | #fileNotExist
  | #noEnoughRAM
  | #failedToExecScript
  | #invalidThreads
  | #invalidPercentage
  | #threadsAndPercentageSpecified
]

let execScript = (ns, target, script, ~threads=?, ~percentage=?, ~upload=true, ~args=?) => {
  let args = args->Option.getOr([])->Array.map(arg => NSTypes.StringArg(arg))

  if upload && !(ns->uploadFile(target, script)) {
    Error(#failedToUploadFile)
  } else {
    let scriptRAM = ns->NS.getScriptRam(script, ~host=target)

    if scriptRAM > 0.0 {
      let exec = threads =>
        if threads >= 1 {
          let pid = ns->NS.exec(script, target, ~threads, ~args)
          if pid !== 0 {
            Ok((pid, threads, scriptRAM *. threads->Int.toFloat))
          } else {
            Error(#failedToExecScript)
          }
        } else {
          Error(#invalidThreads)
        }

      switch (threads, percentage) {
      | (Some(threads), None) => exec(threads)
      | (None, Some(_)) | (None, None) => {
          let percentage = percentage->Option.getOr(1.0)

          if percentage > 0.0 && percentage <= 1.0 {
            let ram =
              (ns->NS.getServerMaxRam(target) -. ns->NS.getServerUsedRam(target)) *. percentage
            if ram > 0.0 && ram >= scriptRAM {
              exec((ram /. scriptRAM)->Js.Math.floor_int)
            } else {
              Error(#noEnoughRAM)
            }
          } else {
            Error(#invalidPercentage)
          }
        }
      | (Some(_), Some(_)) => Error(#threadsAndPercentageSpecified)
      }
    } else {
      Error(#fileNotExist)
    }
  }
}
