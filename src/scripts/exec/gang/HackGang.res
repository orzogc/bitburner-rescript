let ascendScript = "/scripts/exec/gang/Ascend.res.js"

let main: NS.main = async ns => {
  let (flags, _) = ns->Flags.getFlagsExn(Flags.onlyHelpSchema)
  let gang = ns->NS.gang

  if flags["help"] {
    ns->NS.tprint("Auto manages a hacking gang.")
  } else if !(gang->Gang.inGang) {
    ns->NS.tprint("ERROR: not in a gang")
  } else if !(gang->Gang.getGangInformation).isHacking {
    ns->NS.tprint("ERROR: not in a hacking gang")
  } else {
    while true {
      let toAscend = ref(None)
      let waitLonger = ref(true)

      gang
      ->Gang.getMemberNames
      ->Array.forEach(member => {
        switch gang->Gang.getAscensionResult(member) {
        | Some(ascension) =>
          switch toAscend.contents {
          | Some((max, _)) =>
            if ascension.hack > max {
              toAscend := Some((ascension.hack, member))
            }
          | None => toAscend := Some((ascension.hack, member))
          }
        | None => ()
        }
      })

      switch toAscend.contents {
      | Some((factor, member)) => {
          ns->NS.print(`INFO: ascending ${member}, multiplier factor ${factor->Float.toString}`)

          if await ns->GangUtils.ascendAndBuyEquipments(member) {
            if await ns->GangUtils.train(member, Hacking, ~milliseconds=300000) {
              waitLonger := false
            }
          } else {
            ns->NS.print(`ERROR: failed to ascend ${member}`)
          }
        }
      | None => ()
      }

      if waitLonger.contents {
        await ns->Helpers.sleep(600000)
      } else {
        await ns->Helpers.sleep(300000)
      }
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let args = args->Flags.argsToStrings
  if !(args->Flags.argsHasHelp) {
    Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema)->ignore
  }

  []
}
