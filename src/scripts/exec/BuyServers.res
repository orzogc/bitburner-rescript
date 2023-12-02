let schema = {
  "ram": nan,
  "count": nan,
  "prefix": "myserver",
  "continuous": false,
  "dry": false,
  "help": false,
}

let main: NS.main = async ns => {
  let (flags, _) = ns->Flags.getFlagsExn(schema)
  let ram = flags["ram"]
  let count = flags["count"]
  let prefix = flags["prefix"]
  let continuous = flags["continuous"]
  let dry = flags["dry"]

  if flags["help"] {
    ns->NS.tprint("Buys servers.
--ram int : Servers' RAM.
--count int : How many servers to buy. If not specified, buys servers as many as possible.
--prefix string : Servers' hostname prefix. Defaults to 'myserver'.
--continuous : Buys servers continuously.
--dry : Only prints the info of buying servers, not actually buying.")
  } else if !(ram->Helpers.isInteger && ram > 0.0 && Math.log2(ram)->Helpers.isInteger) {
    ns->NS.tprint(
      `ERROR: servers' RAM is not an integer, less than 1 or not a power of 2: ${ram->Float.toString}`,
    )
  } else if !(count->Float.isNaN || (count->Helpers.isInteger && count > 0.0)) {
    ns->NS.tprint(
      `ERROR: servers' count to buy is not an integer or less than 1: ${count->Float.toString}`,
    )
  } else {
    let ram = Math.min(ram, ns->NS.getPurchasedServerMaxRam)
    let count = Js.Math.min_int(
      count->Float.toInt,
      ns->NS.getPurchasedServerLimit - ns->NS.getPurchasedServers->Array.length,
    )

    ns->NS.tprint(`INFO: the RAM of purchased servers: ${ram->Float.toString}`)
    ns->NS.tprint(`INFO: the count of servers to purchase: ${count->Int.toString}`)
    let singleCost = ns->NS.getPurchasedServerCost(ram)
    ns->NS.tprint(
      `INFO: a single server's cost: ${singleCost->Float.toString} , full cost: ${(singleCost *.
        count->Int.toFloat)->Float.toString}`,
    )

    if !dry && ram > 0.0 && count > 0 {
      let n = ref(0)
      let shouldContinue = ref(true)
      let breakOrSleep = async () => {
        if continuous {
          (await ns->NS.asleep(60000.0))->ignore
        } else {
          shouldContinue := false
        }
      }

      while n.contents < count && shouldContinue.contents {
        if ns->NS.getPlayerMoney >= singleCost {
          if (
            ns->NS.purchaseServer(`${prefix}-${n.contents->Int.toString}`, ram)->String.length > 0
          ) {
            n := n.contents + 1
          } else {
            ns->NS.print("ERROR: failed to purchase a server")
            await breakOrSleep()
          }
        } else {
          await breakOrSleep()
        }
      }
    } else {
      ns->NS.tprint(`INFO: no servers to purchase`)
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let setFlags = () => Flags.schemaToFlagsExn(data.flags, schema)->ignore
  let args = args->Flags.argsToStrings

  if args->Flags.argsHasHelp {
    []
  } else {
    switch args->Array.at(-2) {
    | Some("--ram") | Some("--count") | Some("--prefix") => setFlags()
    | _ => ()
    }

    switch (args->Array.at(-2), args->Array.at(-1)) {
    | (Some("--ram"), _)
    | (_, Some("--ram"))
    | (Some("--count"), _)
    | (_, Some("--count"))
    | (Some("--prefix"), _)
    | (_, Some("--prefix")) => ()
    | _ => setFlags()
    }

    []
  }
}
