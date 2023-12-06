let onlyHelpSchema = {"help": false}

/** Converts arguments to an array of strings. */
let argsToStrings = args =>
  args->Array.map(arg =>
    switch arg {
    | NSTypes.StringArg(s) => s
    | NumberArg(f) => f->Float.toString
    | BoolArg(b) => b->string_of_bool
    }
  )

let stringsToArgs = strings => strings->Array.map(s => NSTypes.StringArg(s))

let argsHasHelp = args => args->Array.some(arg => arg === "--help")

/** Converts schema to flags.

 The First argument is a function to get flags.

 The second argument is an Object in which keys are flag names and values are default values of flags.
 The type of values must be a string, float, bool or array of strings.

 Returns flags from NS and remaining arguments which are not listed in the Object's keys.
 */
let schemaToFlagsExn: 'a. (NSTypes.getFlags, {..} as 'a) => ('a, array<string>) = (
  getFlags,
  obj,
) => {
  let schema =
    obj
    ->Object.keysToArray
    ->Array.map(key => {
      let value = obj->Object.get(key)->Option.getUnsafe
      if value->Array.isArray {
        value->Array.forEach(v => {
          if v->Type.typeof !== #string {
            invalid_arg("Object's value is an array, but not an array of string")
          }
        })

        (key, NSTypes.ArrayFlag(value))
      } else {
        switch value->Type.typeof {
        | #string => (key, NSTypes.StringFlag(value))
        | #number => (key, NSTypes.NumberFlag(value))
        | #boolean => (key, NSTypes.BoolFlag(value))
        | _ => invalid_arg("Object's value must be a string, float, bool or array of strings")
        }
      }
    })

  let flags = getFlags(schema)

  // returned flags may contain `null` value
  flags
  ->Dict.valuesToArray
  ->Array.forEach(v =>
    if v->Obj.magic === Null.null {
      invalid_arg("flags' values contain null")
    }
  )

  let remains = switch flags->Dict.get("_") {
  | Some(ArrayFlag(array)) =>
    // the array may contain other value type
    array->Array.map(value =>
      switch value->Type.typeof {
      | #string => value
      | #number => value->Obj.magic->Float.toString
      | #boolean => value->Obj.magic->string_of_bool
      | _ => failwith("the array contains wrong value type")
      }
    )
  | None => []
  | _ => failwith("remaining arguments is not an array of strings")
  }

  (flags->Obj.magic, remains)
}

/** Gets flags from NS.

 The second argument is an Object in which keys are flag names and values are default values of flags.
 The type of values must be a string, float, bool or array of strings.

 Returns flags from NS and remaining arguments which are not listed in the Object's keys.
 */
let getFlagsExn: 'a. (NS.t, {..} as 'a) => ('a, array<string>) = (ns, obj) =>
  schemaToFlagsExn(NS.flags(ns, ...), obj)
