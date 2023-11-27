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
