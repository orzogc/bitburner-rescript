// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";

async function main(ns) {
  var match = Flags.getFlagsExn(ns, Flags.onlyHelpSchema);
  if (match[0].help) {
    ns.tprint("Share RAM to factions.");
    return ;
  }
  while(true) {
    await ns.share();
  };
}

export {
  main ,
}
/* No side effect */
