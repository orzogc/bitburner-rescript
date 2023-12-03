let schema = {
  "ram": nan,
  "dry": false,
  "help": false,
}

let main: NS.main = async ns => {
  let (flags, _) = ns->Flags.getFlagsExn(schema)
  let ram = flags["ram"]
  let dry = flags["dry"]
  let maxRam = ns->NS.getPurchasedServerMaxRam

  if flags["help"] {
    ns->NS.tprint("Upgrades purchased servers.
--ram int : Servers' RAM which upgrades to, must be a power of 2.
--dry : Only prints the info of upgrading servers, does not actually upgrade.")
  } else if (
    !(ram->Helpers.isInteger && ram > 0.0 && Math.log2(ram)->Helpers.isInteger && ram <= maxRam)
  ) {
    let ramString = if ram->Float.isNaN {
      ""
    } else {
      " : " ++ ns->NS.formatRam(ram)
    }
    ns->NS.tprint(
      `ERROR: servers' RAM is missing, not an integer, less than 1, not a power of 2 or greater than the max RAM ${ns->NS.formatRam(
          maxRam,
        )}${ramString}`,
    )
  } else {
    let servers = ns->NS.getPurchasedServers
    let cost =
      servers->Array.reduce(0.0, (c, server) =>
        c +. Math.max(ns->NS.getPurchasedServerUpgradeCost(server, ram), 0.0)
      )
    ns->NS.tprint(
      `INFO: the full cost of upgrading all servers to RAM ${ns->NS.formatRam(
          ram,
        )} is ${ns->NS.formatMoney(cost)}`,
    )

    if !dry {
      servers->Array.forEach(server =>
        if !(ns->NS.upgradePurchasedServer(server, ram)) {
          ns->NS.tprint(`ERROR: failed to upgrade server ${server}`)
        }
      )
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let args = args->Flags.argsToStrings

  if !(args->Flags.argsHasHelp) {
    switch args->Array.at(-1) {
    | Some("--ram") => ()
    | _ => Flags.schemaToFlagsExn(data.flags, schema)->ignore
    }
  }

  []
}
