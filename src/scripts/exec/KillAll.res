let main = async ns => {
  let (flags, args) = ns->Helpers.getFlagsExn({
    "onlyPurchasedServers": false,
    "excludePurchasedServers": false,
    "help": false,
  })
  let onlyPurchasedServers = flags["onlyPurchasedServers"]
  let excludePurchasedServers = flags["excludePurchasedServers"]

  if flags["help"] {
    ns->NS.tprint("Kills all running scripts on servers.
If no arguments exist, kills all running scripts on all servers excluding home.
--onlyPurchasedServers : Only kills all running scripts on purchased servers.
--excludePurchasedServers : Kills all running scripts on all servers excluding home and purchased servers.
If other arguments exist, Kills all running scripts on servers which hostname in these arguments, onlyMyServers and excludeMyServers are ignored.")
  } else if onlyPurchasedServers && excludePurchasedServers {
    ns->NS.tprint(
      "ERROR: onlyPurchasedServers and excludePurchasedServers can not be used at the same time",
    )
  } else {
    let killServer = host =>
      if !(ns->NS.killall(~host, ~safetyguard=true)) {
        ns->NS.print(`WARN: no scripts were killed on server ${host}`)
      }

    if args->Array.length > 0 {
      args->Array.forEach(killServer)
    } else if onlyPurchasedServers {
      ns->NS.getPurchasedServers->Array.forEach(killServer)
    } else {
      ns->Helpers.crawlServers(~excludePurchasedServers)->Set.forEach(killServer)
    }
  }
}