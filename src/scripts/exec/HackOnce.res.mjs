// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";

async function main(ns) {
  var match = Flags.getFlagsExn(ns, Flags.onlyHelpSchema);
  if (match[0].help) {
    ns.tprint("Hacks the server once.\nThe first argument should be the target server's hostname.");
    return ;
  }
  var server = match[1][0];
  if (server !== undefined) {
    await ns.hack(server, undefined);
  } else {
    ns.tprint("ERROR: The first argument is missing. It should be the target server's hostname.");
  }
}

function autocomplete(data, param) {
  var match = Flags.schemaToFlagsExn(data.flags, Flags.onlyHelpSchema);
  if (match[0].help) {
    return [];
  } else {
    return data.servers;
  }
}

export {
  main ,
  autocomplete ,
}
/* No side effect */
