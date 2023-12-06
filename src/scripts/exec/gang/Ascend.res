let schema = {
  "buyOwnedEquipments": false,
  "waitForEnoughMoney": false,
  "help": false,
}

let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn(schema)
  let buyOwnedEquipments = flags["buyOwnedEquipments"]
  let waitForEnoughMoney = flags["waitForEnoughMoney"]

  if flags["help"] {
    ns->NS.tprint("Ascends gang members.
--buyOwnedEquipments : Buys members' owned equipments after ascending.
--waitForEnoughMoney : Waits for enough money to buy equipments. It must be used with buyOwnedEquipments.
Other arguments are gang members' names")
  } else if args->Array.length === 0 {
    ns->NS.tprint("ERROR: missing gang members' names")
  } else if waitForEnoughMoney && !buyOwnedEquipments {
    ns->NS.tprint("ERROR: waitForEnoughMoney must be used with buyOwnedEquipments")
  } else {
    for i in 0 to args->Array.length - 1 {
      let name = args[i]->Option.getExn
      let result = if waitForEnoughMoney && buyOwnedEquipments {
        await ns->GangUtils.ascendAndBuyEquipments(name)
      } else {
        ns->GangUtils.ascend(name, ~buyOwnedEquipments)
      }

      if result {
        ns->NS.print(`SUCCESS: ascended ${name}`)
      } else {
        ns->NS.print(`ERROR: failed to ascend ${name}`)
      }
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let args = args->Flags.argsToStrings

  if !(args->Flags.argsHasHelp) {
    Flags.schemaToFlagsExn(data.flags, schema)->ignore
  }

  []
}
