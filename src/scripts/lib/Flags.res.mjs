// Generated by ReScript, PLEASE EDIT WITH CARE

import * as PervasivesU from "rescript/lib/es6/pervasivesU.js";

var onlyHelpSchema = {
  help: false
};

function argsToStrings(args) {
  return args.map(function (arg) {
              switch (typeof arg) {
                case "string" :
                    return arg;
                case "number" :
                    return arg.toString();
                case "boolean" :
                    return PervasivesU.string_of_bool(arg);
                
              }
            });
}

function stringsToArgs(strings) {
  return strings.map(function (s) {
              return s;
            });
}

function argsHasHelp(args) {
  return args.some(function (arg) {
              return arg === "--help";
            });
}

function schemaToFlagsExn(getFlags, obj) {
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
  var flags = getFlags(schema);
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

function getFlagsExn(ns, obj) {
  return schemaToFlagsExn((function (extra) {
                return ns.flags(extra);
              }), obj);
}

export {
  onlyHelpSchema ,
  argsToStrings ,
  stringsToArgs ,
  argsHasHelp ,
  schemaToFlagsExn ,
  getFlagsExn ,
}
/* No side effect */
