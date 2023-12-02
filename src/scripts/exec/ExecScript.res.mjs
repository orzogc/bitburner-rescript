// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "../lib/Flags.res.mjs";
import * as Helpers from "../lib/Helpers.res.mjs";

var schema = {
  target: "",
  script: "",
  threads: Number.NaN,
  percentage: Number.NaN,
  upload: false,
  help: false
};

async function main(ns) {
  var match = Flags.getFlagsExn(ns, schema);
  var args = match[1];
  var flags = match[0];
  var target = flags.target;
  var script = flags.script;
  var threads = flags.threads;
  var percentage = flags.percentage;
  var upload = flags.upload;
  if (flags.help) {
    ns.tprint("Runs a script on target servers.\n--target string : Targer servers, can be 'allServers', 'purchasedServers', 'allServersExcludePurchasedServers' (these all excludes home server) or servers' hostnames separated by comma.\n--script string : Script to run.\n--threads int : An integer which is greater or equal to 1. Runs the script by specified threads.\n--percentage float : A float which is greater than 0 and less than 1. Runs the script using specified percentage of free memory.\n--upload : Whether uploads the script on current server to target server.\nOther arguments are passed to the script.\nIf threads and percentage are not specified, runs the script by max threads.\nThreads and percentage must not be used at the same time.");
    return ;
  }
  if (target.length === 0) {
    ns.tprint("ERROR: no target in flags");
    return ;
  }
  if (script.length === 0) {
    ns.tprint("ERROR: no script in flags");
    return ;
  }
  if (isNaN(threads) || Number.isInteger(threads) && threads >= 1.0) {
    if (isNaN(percentage) || percentage > 0.0 && percentage < 1.0) {
      if (!isNaN(threads) && !isNaN(percentage)) {
        ns.tprint("ERROR: threads and percentage must not be used at the same time.");
        return ;
      }
      var threads$1 = Number.isInteger(threads) && threads >= 1.0 ? threads | 0 : undefined;
      var percentage$1 = percentage > 0.0 && percentage < 1.0 ? percentage : undefined;
      var servers = target === "allServers" ? Helpers.crawlServers(ns, undefined, undefined) : (
          target === "purchasedServers" ? new Set(ns.getPurchasedServers()) : (
              target === "allServersExcludePurchasedServers" ? Helpers.crawlServers(ns, true, undefined) : new Set(target.split(","))
            )
        );
      servers.forEach(function (server) {
            var e = Helpers.execScript(ns, server, script, threads$1, percentage$1, upload, args);
            if (e.TAG === "Ok") {
              return ;
            }
            ns.tprint("ERROR: failed to run script " + script + " on server " + server + ": ", e._0);
          });
      return ;
    }
    ns.tprint("ERROR: percentage must be a float which is greater than 0 and less than 1");
    return ;
  }
  ns.tprint("ERROR: threads must be an integer which is greater or equal to 1");
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
      case "--percentage" :
      case "--script" :
      case "--target" :
      case "--threads" :
          setFlags();
          break;
      default:
        
    }
  }
  var match$1 = args$1.at(-2);
  var match$2 = args$1.at(-1);
  var exit = 0;
  var exit$1 = 0;
  var exit$2 = 0;
  if (match$1 === "--target") {
    exit = 2;
  } else {
    exit$2 = 4;
  }
  if (exit$2 === 4) {
    if (match$2 !== undefined) {
      switch (match$2) {
        case "--script" :
            return data.scripts;
        case "--target" :
            exit = 2;
            break;
        default:
          exit$1 = 3;
      }
    } else {
      exit$1 = 3;
    }
  }
  if (exit$1 === 3) {
    if (match$1 !== undefined) {
      switch (match$1) {
        case "--script" :
            return data.scripts;
        case "--percentage" :
        case "--threads" :
            return [];
        default:
          exit = 1;
      }
    } else {
      exit = 1;
    }
  }
  switch (exit) {
    case 1 :
        if (match$2 !== undefined) {
          switch (match$2) {
            case "--percentage" :
            case "--threads" :
                return [];
            default:
              setFlags();
              return [];
          }
        } else {
          setFlags();
          return [];
        }
    case 2 :
        var $$arguments = data.servers.slice();
        $$arguments.push("allServers", "purchasedServers", "allServersExcludePurchasedServers");
        return $$arguments;
    
  }
}

export {
  schema ,
  main ,
  autocomplete ,
}
/* schema Not a pure module */