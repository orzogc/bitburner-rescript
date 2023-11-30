let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)

  if flags["help"] {
    ns->NS.tprint("Weakens the server continuously.
The first argument should be the target server's hostname.")
  } else {
    let server = args[0]->Option.getOr("foodnstuff")

    while true {
      (await ns->NS.weaken(server))->ignore
    }
  }
}

let autocomplete: NS.autocomplete = (data, _) => {
  let (flags, _) = Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema)

  if flags["help"] {
    []
  } else {
    data.servers
  }
}
