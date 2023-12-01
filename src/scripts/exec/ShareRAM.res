let main: NS.main = async ns => {
  let (flags, _) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)

  if flags["help"] {
    ns->NS.tprint("Share RAM to factions.")
  } else {
    while true {
      await ns->NS.share
    }
  }
}
