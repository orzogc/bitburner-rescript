let main: NS.main = async ns => {
  let (flags, _) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)

  if flags["help"] {
    ns->NS.tprint("Share RAM to factions continuously.")
  } else {
    while true {
      await ns->NS.share
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  if !(args->Flags.argsToStrings->Flags.argsHasHelp) {
    Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema)->ignore
  }

  []
}
