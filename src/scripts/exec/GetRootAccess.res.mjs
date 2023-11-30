// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";
import * as Helpers from "../lib/Helpers.res.mjs";

async function main(ns) {
  var match = Flags.getFlagsExn(ns, Flags.onlyHelpSchema);
  var args = match[1];
  if (match[0].help) {
    ns.tprint("Tries to get root access on servers.\nArguments are servers' hostnames. If no arguments, tries to get root access on all servers.");
  } else if (args.length > 0) {
    args.forEach(function (s) {
          Helpers.getRootAccess(ns, s);
        });
  } else {
    Helpers.crawlServers(ns, undefined, undefined).forEach(function (s) {
          Helpers.getRootAccess(ns, s);
        });
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
