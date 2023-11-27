let getFlagsExn: 'a. (NS.t, {..} as 'a) => ('a, array<string>) = (ns, obj) => {
  let schema =
    obj
    ->Object.keysToArray
    ->Array.map(key => {
      let value = obj->Object.get(key)->Option.getExn
      if value->Array.isArray {
        value->Array.forEach(v => {
          if v->Type.typeof !== #string {
            invalid_arg("object's value is not a array of string")
          }
        })

        (key, NSTypes.ArrayFlag(value))
      } else {
        switch value->Type.typeof {
        | #string => (key, NSTypes.StringFlag(value))
        | #number => (key, NSTypes.NumberFlag(value))
        | #boolean => (key, NSTypes.BoolFlag(value))
        | _ => invalid_arg("object's value must be a string, float or bool")
        }
      }
    })

  let flags = ns->NS.flags(schema)

  (flags->Obj.magic, flags->Dict.get("_")->Obj.magic)
}
