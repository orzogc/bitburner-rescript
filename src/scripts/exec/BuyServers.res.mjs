// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";

var schema = {
  ram: Number.NaN,
  count: Number.NaN,
  prefix: "myserver",
  continuous: false,
  dry: false,
  help: false
};

async function main(ns) {
  var match = Flags.getFlagsExn(ns, schema);
  var flags = match[0];
  var ram = flags.ram;
  var count = flags.count;
  var prefix = flags.prefix;
  var continuous = flags.continuous;
  var dry = flags.dry;
  if (flags.help) {
    ns.tprint("Buys servers.\n--ram int : Servers' RAM.\n--count int : How many servers to buy. If not specified, buys servers as many as possible.\n--prefix string : Servers' hostname prefix. Defaults to 'myserver'.\n--continuous : Buys servers continuously.\n--dry : Only prints the info of buying servers, not actually buying.");
    return ;
  }
  if (Number.isInteger(ram) && ram > 0.0 && Number.isInteger(Math.log2(ram))) {
    if (isNaN(count) || Number.isInteger(count) && count > 0.0) {
      var ram$1 = Math.min(ram, ns.getPurchasedServerMaxRam());
      var count$1 = Math.min(count | 0, ns.getPurchasedServerLimit() - ns.getPurchasedServers().length | 0);
      ns.tprint("INFO: the RAM of purchased servers: " + ram$1.toString());
      ns.tprint("INFO: the count of servers to purchase: " + count$1.toString());
      var singleCost = ns.getPurchasedServerCost(ram$1);
      ns.tprint("INFO: a single server's cost: " + singleCost.toString() + " , full cost: " + (singleCost * count$1).toString());
      if (!dry && ram$1 > 0.0 && count$1 > 0) {
        var n = 0;
        var shouldContinue = {
          contents: true
        };
        var breakOrSleep = async function () {
          if (continuous) {
            await ns.asleep(60000.0);
          } else {
            shouldContinue.contents = false;
          }
        };
        while(n < count$1 && shouldContinue.contents) {
          if (ns.getServerMoneyAvailable("home") >= singleCost) {
            if (ns.purchaseServer(prefix + "-" + n.toString(), ram$1).length > 0) {
              n = n + 1 | 0;
            } else {
              ns.print("ERROR: failed to purchase a server");
              await breakOrSleep();
            }
          } else {
            await breakOrSleep();
          }
        };
        return ;
      }
      ns.tprint("INFO: no servers to purchase");
      return ;
    }
    ns.tprint("ERROR: servers' count to buy is not an integer or less than 1: " + count.toString());
    return ;
  }
  ns.tprint("ERROR: servers' RAM is not an integer, less than 1 or not a power of 2: " + ram.toString());
}

function autocomplete(data, args) {
  var setFlags = function () {
    Flags.schemaToFlagsExn(data.flags, schema);
  };
  var args$1 = Flags.argsToStrings(args);
  if (Flags.argsHasHelp(args$1)) {
    return [];
  }
  var match = args$1.at(-2);
  if (match !== undefined) {
    switch (match) {
      case "--count" :
      case "--prefix" :
      case "--ram" :
          setFlags();
          break;
      default:
        
    }
  }
  var match$1 = args$1.at(-2);
  var match$2 = args$1.at(-1);
  var exit = 0;
  if (match$1 !== undefined) {
    switch (match$1) {
      case "--count" :
      case "--prefix" :
      case "--ram" :
          break;
      default:
        exit = 1;
    }
  } else {
    exit = 1;
  }
  if (exit === 1) {
    if (match$2 !== undefined) {
      switch (match$2) {
        case "--count" :
        case "--prefix" :
        case "--ram" :
            break;
        default:
          setFlags();
      }
    } else {
      setFlags();
    }
  }
  return [];
}

export {
  schema ,
  main ,
  autocomplete ,
}
/* schema Not a pure module */