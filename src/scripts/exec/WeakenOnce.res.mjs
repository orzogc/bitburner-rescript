// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";

async function main(ns) {
  var match = Flags.getFlagsExn(ns, Flags.onlyHelpSchema);
  if (match[0].help) {
    ns.tprint("Weakens the server once.\nThe first argument should be the target server's hostname.");
    return ;
  }
  var server = match[1][0];
  if (server !== undefined) {
    await ns.weaken(server, undefined);
  } else {
    ns.tprint("ERROR: The first argument is missing. It should be the target server's hostname.");
  }
}

function autocomplete(data, args) {
  var args$1 = Flags.argsToStrings(args);
  if (Flags.argsHasHelp(args$1)) {
    return [];
  } else {
    Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema);
    if (args$1.length <= 1) {
      return data.servers;
    } else {
      return [];
    }
  }
}

export {
  main ,
  autocomplete ,
}
/* No side effect */
