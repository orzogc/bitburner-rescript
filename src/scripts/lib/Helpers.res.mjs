// Generated by ReScript, PLEASE EDIT WITH CARE

import * as PervasivesU from "rescript/lib/es6/pervasivesU.js";

function getFlagsExn(ns, obj) {
  var schema = Object.keys(obj).map(function (key) {
        var value = obj[key];
        if (Array.isArray(value)) {
          value.forEach(function (v) {
                if (typeof v !== "string") {
                  return PervasivesU.invalid_arg("Object's value is an array, but not an array of string");
                }
                
              });
          return [
                  key,
                  value
                ];
        }
        var match = typeof value;
        if (match === "boolean") {
          return [
                  key,
                  value
                ];
        } else if (match === "string") {
          return [
                  key,
                  value
                ];
        } else if (match === "number") {
          return [
                  key,
                  value
                ];
        } else {
          return PervasivesU.invalid_arg("Object's value must be a string, float, bool or array of strings");
        }
      });
  var flags = ns.flags(schema);
  Object.values(flags).forEach(function (v) {
        if (v === null) {
          return PervasivesU.invalid_arg("flags' values contain null");
        }
        
      });
  var match = flags["_"];
  var remains = match !== undefined ? (
      Array.isArray(match) ? match.map(function (value) {
              var match = typeof value;
              if (match === "boolean") {
                return PervasivesU.string_of_bool(value);
              } else if (match === "string") {
                return value;
              } else if (match === "number") {
                return value.toString();
              } else {
                return PervasivesU.failwith("the array contains wrong value type");
              }
            }) : PervasivesU.failwith("remaining arguments is not an array of strings")
    ) : [];
  return [
          flags,
          remains
        ];
}

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

function getRootAccess(ns, host) {
  var info = ns.getServer(host);
  if (info.hasAdminRights) {
    ns.print("INFO: server " + host + " has root access already");
    return true;
  }
  var match = info.openPortCount;
  var match$1 = info.numOpenPortsRequired;
  if (match !== undefined && match$1 !== undefined) {
    if (match < match$1) {
      if (!info.sshPortOpen && ns.fileExists("BruteSSH.exe", "home")) {
        ns.brutessh(host);
      }
      var info$1 = ns.getServer(host);
      if (info$1.openPortCount < info$1.numOpenPortsRequired && !info$1.ftpPortOpen && ns.fileExists("FTPCrack.exe", "home")) {
        ns.ftpcrack(host);
      }
      var info$2 = ns.getServer(host);
      if (info$2.openPortCount < info$2.numOpenPortsRequired && !info$2.smtpPortOpen && ns.fileExists("relaySMTP.exe", "home")) {
        ns.relaysmtp(host);
      }
      var info$3 = ns.getServer(host);
      if (info$3.openPortCount < info$3.numOpenPortsRequired && !info$3.httpPortOpen && ns.fileExists("HTTPWorm.exe", "home")) {
        ns.httpworm(host);
      }
      var info$4 = ns.getServer(host);
      if (info$4.openPortCount < info$4.numOpenPortsRequired && !info$4.sqlPortOpen && ns.fileExists("SQLInject.exe", "home")) {
        ns.sqlinject(host);
      }
      
    }
    var info$5 = ns.getServer(host);
    if (info$5.openPortCount >= info$5.numOpenPortsRequired) {
      if (ns.fileExists("NUKE.exe", "home")) {
        ns.nuke(host);
        var info$6 = ns.getServer(host);
        if (info$6.hasAdminRights) {
          ns.print("SUCCESS: server " + host + " has root access now");
          return true;
        } else {
          ns.print("ERROR: failed to get root access on server " + host);
          return false;
        }
      }
      ns.print("ERROR: no NUKE.exe on home server");
      return false;
    }
    ns.print("ERROR: failed to get root access on server " + host + " because of no enough ports opened");
    return false;
  }
  ns.print("ERROR: no ports to open on server " + host);
  return false;
}

export {
  getFlagsExn ,
  crawlServers ,
  getRootAccess ,
}
/* No side effect */