/** Gets flags from NS.

 The second argument is an Object in which keys are flag names and values are default values of flags.
 The type of values must be a string, float, bool or array of strings.

 Returns flags from NS and remaining arguments which are not listed in the Object's keys.
 */
let getFlagsExn: 'a. (NS.t, {..} as 'a) => ('a, array<string>) = (ns, obj) => {
  let schema =
    obj
    ->Object.keysToArray
    ->Array.map(key => {
      let value = obj->Object.get(key)->Option.getUnsafe
      if value->Array.isArray {
        value->Array.forEach(v => {
          if v->Type.typeof !== #string {
            invalid_arg("Object's value is an array, but not an array of string")
          }
        })

        (key, NSTypes.ArrayFlag(value))
      } else {
        switch value->Type.typeof {
        | #string => (key, NSTypes.StringFlag(value))
        | #number => (key, NSTypes.NumberFlag(value))
        | #boolean => (key, NSTypes.BoolFlag(value))
        | _ => invalid_arg("Object's value must be a string, float, bool or array of strings")
        }
      }
    })

  let flags = ns->NS.flags(schema)

  // returned flags may contain `null` value
  flags
  ->Dict.valuesToArray
  ->Array.forEach(v =>
    if v->Obj.magic === Null.null {
      invalid_arg("flags' values contain null")
    }
  )

  let remains = switch flags->Dict.get("_") {
  | Some(ArrayFlag(array)) =>
    // the array may contain other value type
    array->Array.map(value =>
      switch value->Type.typeof {
      | #string => value
      | #number => value->Obj.magic->Float.toString
      | #boolean => value->Obj.magic->string_of_bool
      | _ => failwith("the array contains wrong value type")
      }
    )
  | None => []
  | _ => failwith("remaining arguments is not an array of strings")
  }

  (flags->Obj.magic, remains)
}

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
    ns->NS.print(`INFO: server ${host} has root access already`)

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
              ns->NS.print(`SUCCESS: server ${host} has root access now`)

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
          ns->NS.print(
            `ERROR: failed to get root access on server ${host} because of no enough ports opened`,
          )

          false
        }
      }
    | _ => {
        ns->NS.print(`ERROR: no ports to open on server ${host}`)

        false
      }
    }
  }
}
