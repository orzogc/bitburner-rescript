// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";
import * as Helpers from "../lib/Helpers.res.mjs";

var schema = {
  onlyPurchasedServers: false,
  excludePurchasedServers: false,
  help: false
};

async function main(ns) {
  var match = Flags.getFlagsExn(ns, schema);
  var args = match[1];
  var flags = match[0];
  var onlyPurchasedServers = flags.onlyPurchasedServers;
  var excludePurchasedServers = flags.excludePurchasedServers;
  if (flags.help) {
    ns.tprint("Kills all running scripts on servers.\nIf no arguments exist, kills all running scripts on all servers excluding home.\n--onlyPurchasedServers : Only kills all running scripts on purchased servers.\n--excludePurchasedServers : Kills all running scripts on all servers excluding home and purchased servers.\nIf other arguments exist, Kills all running scripts on servers which hostname in these arguments, onlyMyServers and excludeMyServers are ignored.");
    return ;
  }
  if (onlyPurchasedServers && excludePurchasedServers) {
    ns.tprint("ERROR: onlyPurchasedServers and excludePurchasedServers can not be used at the same time");
    return ;
  }
  var killServer = function (host) {
    if (!ns.killall(host, true)) {
      ns.print("WARN: no scripts were killed on server " + host);
      return ;
    }
    
  };
  if (args.length > 0) {
    args.forEach(killServer);
  } else if (onlyPurchasedServers) {
    ns.getPurchasedServers().forEach(killServer);
  } else {
    Helpers.crawlServers(ns, excludePurchasedServers, undefined).forEach(killServer);
  }
}

function autocomplete(data, args) {
  var args$1 = Flags.argsToStrings(args);
  if (args$1.some(function (arg) {
          return arg === "--help" || arg === "--onlyPurchasedServers" ? true : arg === "--excludePurchasedServers";
        })) {
    return [];
  } else {
    if (args$1.length <= 1) {
      Flags.schemaToFlagsExn(data.flags, schema);
    }
    return data.servers;
  }
}

export {
  schema ,
  main ,
  autocomplete ,
}
/* No side effect */
