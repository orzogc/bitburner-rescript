let rootAccess = (ns, server) =>
  if ns->Helpers.getRootAccess(server) {
    ns->NS.print(`SUCCESS: server ${server} has root access now`)
  } else {
    ns->NS.print(`ERROR: failed to get root access on server ${server}`)
  }

let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)
  if flags["help"] {
    ns->NS.tprint("Tries to get root access on servers.
Arguments are servers' hostnames. If no arguments, tries to get root access on all servers.")
  } else if args->Array.length > 0 {
    args->Array.forEach(s => ns->rootAccess(s))
  } else {
    ns->Helpers.crawlServers->Set.forEach(s => ns->rootAccess(s))
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  if args->Flags.argsToStrings->Flags.argsHasHelp {
    []
  } else {
    Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema)->ignore

    data.servers
  }
}
