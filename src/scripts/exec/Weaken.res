let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)

  if flags["help"] {
    ns->NS.tprint("Weakens the server continuously.
The first argument should be the target server's hostname. If not specified, defaults to foodnstuff")
  } else {
    let server = args[0]->Option.getOr("foodnstuff")

    while true {
      (await ns->NS.weaken(server))->ignore
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let args = args->Flags.argsToStrings

  if args->Flags.argsHasHelp {
    []
  } else {
    Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema)->ignore

    if args->Array.length <= 1 {
      data.servers
    } else {
      []
    }
  }
}
