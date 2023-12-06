// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../../lib/Flags.res.mjs";
import * as GangUtils from "../../lib/GangUtils.res.mjs";
import * as Core__Option from "@rescript/core/src/Core__Option.res.mjs";

var schema = {
  buyOwnedEquipments: false,
  waitForEnoughMoney: false,
  help: false
};

async function main(ns) {
  var match = Flags.getFlagsExn(ns, schema);
  var args = match[1];
  var flags = match[0];
  var buyOwnedEquipments = flags.buyOwnedEquipments;
  var waitForEnoughMoney = flags.waitForEnoughMoney;
  if (flags.help) {
    ns.tprint("Ascends gang members.\n--buyOwnedEquipments : Buys members' owned equipments after ascending.\n--waitForEnoughMoney : Waits for enough money to buy equipments. It must be used with buyOwnedEquipments.\nOther arguments are gang members' names");
    return ;
  }
  if (args.length === 0) {
    ns.tprint("ERROR: missing gang members' names");
    return ;
  }
  if (waitForEnoughMoney && !buyOwnedEquipments) {
    ns.tprint("ERROR: waitForEnoughMoney must be used with buyOwnedEquipments");
    return ;
  }
  for(var i = 0 ,i_finish = args.length; i < i_finish; ++i){
    var name = Core__Option.getExn(args[i]);
    var result = waitForEnoughMoney && buyOwnedEquipments ? await GangUtils.ascendAndBuyEquipments(ns, name) : GangUtils.ascend(ns, name, buyOwnedEquipments);
    if (result) {
      ns.print("SUCCESS: ascended " + name);
    } else {
      ns.print("ERROR: failed to ascend " + name);
    }
  }
}

function autocomplete(data, args) {
  var args$1 = Flags.argsToStrings(args);
  if (!Flags.argsHasHelp(args$1)) {
    Flags.schemaToFlagsExn(data.flags, schema);
  }
  return [];
}

export {
  schema ,
  main ,
  autocomplete ,
}
/* No side effect */
