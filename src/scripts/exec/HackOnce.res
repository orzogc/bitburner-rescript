let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)

  if flags["help"] {
    ns->NS.tprint("Hacks the server once.
The first argument should be the target server's hostname.")
  } else {
    switch args[0] {
    | Some(server) => (await ns->NS.hack(server))->ignore
    | None =>
      ns->NS.tprint(
        "ERROR: The first argument is missing. It should be the target server's hostname.",
      )
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
