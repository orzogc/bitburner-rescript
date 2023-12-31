// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Flags from "./Flags.res.mjs";
import * as Js_math from "rescript/lib/es6/js_math.js";
import * as Core__Option from "@rescript/core/src/Core__Option.res.mjs";
import * as Caml_splice_call from "rescript/lib/es6/caml_splice_call.js";

function crawlServers(ns, excludePurchasedServersOpt, excludeHomeOpt) {
  var excludePurchasedServers = excludePurchasedServersOpt !== undefined ? excludePurchasedServersOpt : false;
  var excludeHome = excludeHomeOpt !== undefined ? excludeHomeOpt : true;
  var servers = new Set();
  var getServers = function (_server, remains) {
    while(true) {
      var server = _server;
      if (servers.has(server)) {
        var s = remains.values().next().value;
        if (s === undefined) {
          return ;
        }
        remains.delete(s);
        _server = s;
        continue ;
      }
      servers.add(server);
      ns.scan(server).forEach(function (s) {
            remains.add(s);
          });
      continue ;
    };
  };
  getServers(ns.getHostname(), new Set());
  if (excludePurchasedServers) {
    ns.getPurchasedServers().forEach(function (s) {
          servers.delete(s);
        });
  }
  if (excludeHome) {
    servers.delete("home");
  }
  return servers;
}

function getRootAccess(ns, target) {
  var info = ns.getServer(target);
  if (info.hasAdminRights) {
    return true;
  }
  var match = info.openPortCount;
  var match$1 = info.numOpenPortsRequired;
  if (match === undefined) {
    return false;
  }
  if (match$1 === undefined) {
    return false;
  }
  if (match < match$1) {
    if (!info.sshPortOpen && ns.fileExists("BruteSSH.exe", "home")) {
      ns.brutessh(target);
    }
    var info$1 = ns.getServer(target);
    if (info$1.openPortCount < info$1.numOpenPortsRequired && !info$1.ftpPortOpen && ns.fileExists("FTPCrack.exe", "home")) {
      ns.ftpcrack(target);
    }
    var info$2 = ns.getServer(target);
    if (info$2.openPortCount < info$2.numOpenPortsRequired && !info$2.smtpPortOpen && ns.fileExists("relaySMTP.exe", "home")) {
      ns.relaysmtp(target);
    }
    var info$3 = ns.getServer(target);
    if (info$3.openPortCount < info$3.numOpenPortsRequired && !info$3.httpPortOpen && ns.fileExists("HTTPWorm.exe", "home")) {
      ns.httpworm(target);
    }
    var info$4 = ns.getServer(target);
    if (info$4.openPortCount < info$4.numOpenPortsRequired && !info$4.sqlPortOpen && ns.fileExists("SQLInject.exe", "home")) {
      ns.sqlinject(target);
    }
    
  }
  var info$5 = ns.getServer(target);
  if (info$5.openPortCount < info$5.numOpenPortsRequired) {
    return false;
  }
  if (ns.fileExists("NUKE.exe", "home")) {
    ns.nuke(target);
    var info$6 = ns.getServer(target);
    if (info$6.hasAdminRights) {
      return true;
    } else {
      ns.print("ERROR: failed to get root access on server " + target);
      return false;
    }
  }
  ns.print("ERROR: no NUKE.exe on home server");
  return false;
}

function uploadFile(ns, target, file) {
  if (ns.fileExists(file, undefined)) {
    if (target === ns.getHostname() || ns.scp(file, target, undefined)) {
      return true;
    } else {
      ns.print("ERROR: failed to upload file " + file + " to server " + target);
      return false;
    }
  } else {
    ns.print("ERROR: file " + file + " does not exist on current server " + ns.getHostname());
    return false;
  }
}

function execScript(ns, target, script, threads, percentage, uploadOpt, args) {
  var upload = uploadOpt !== undefined ? uploadOpt : true;
  var args$1 = Flags.stringsToArgs(Core__Option.getOr(args, []));
  if (upload && !uploadFile(ns, target, script)) {
    return {
            TAG: "Error",
            _0: "failedToUploadFile"
          };
  }
  var scriptRAM = ns.getScriptRam(script, target);
  if (scriptRAM <= 0.0) {
    return {
            TAG: "Error",
            _0: "fileNotExist"
          };
  }
  var exec = function (threads) {
    if (threads < 1) {
      return {
              TAG: "Error",
              _0: "invalidThreads"
            };
    }
    var pid = Caml_splice_call.spliceObjApply(ns, "exec", [
          script,
          target,
          threads,
          args$1
        ]);
    if (pid !== 0) {
      return {
              TAG: "Ok",
              _0: [
                pid,
                threads,
                scriptRAM * threads
              ]
            };
    } else {
      return {
              TAG: "Error",
              _0: "failedToExecScript"
            };
    }
  };
  if (threads !== undefined) {
    if (percentage !== undefined) {
      return {
              TAG: "Error",
              _0: "threadsAndPercentageSpecified"
            };
    } else {
      return exec(threads);
    }
  }
  var percentage$1 = Core__Option.getOr(percentage, 1.0);
  if (!(percentage$1 > 0.0 && percentage$1 <= 1.0)) {
    return {
            TAG: "Error",
            _0: "invalidPercentage"
          };
  }
  var ram = (ns.getServerMaxRam(target) - ns.getServerUsedRam(target)) * percentage$1;
  if (ram > 0.0 && ram >= scriptRAM) {
    return exec(Js_math.floor_int(ram / scriptRAM));
  } else {
    return {
            TAG: "Error",
            _0: "noEnoughRAM"
          };
  }
}

async function sleep(ns, milliseconds) {
  await ns.asleep(milliseconds);
}

export {
  crawlServers ,
  getRootAccess ,
  uploadFile ,
  execScript ,
  sleep ,
}
/* No side effect */
