let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn({"help": false})
  if flags["help"] {
    ns->NS.tprint("Weakens the server once.
The first argument should be the target server's hostname.")
  } else {
    switch args[0] {
    | Some(server) => (await ns->NS.weaken(server))->ignore
    | None =>
      ns->NS.tprint("The first argument is missing. It should be the target server's hostname.")
    }
  }
}
