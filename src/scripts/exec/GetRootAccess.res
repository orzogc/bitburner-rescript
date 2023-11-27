let main = async ns => {
  let (flags, args) = ns->Helpers.getFlagsExn({"help": false})
  if flags["help"] {
    ns->NS.tprint("Tries to get root access on servers.
Arguments are servers' hostnames. If no arguments, tries to get root access on all servers.
")
  } else if args->Array.length > 0 {
    args->Array.forEach(s => ns->Helpers.getRootAccess(s)->ignore)
  } else {
    ns->Helpers.crawlServers->Set.forEach(s => ns->Helpers.getRootAccess(s)->ignore)
  }
}
