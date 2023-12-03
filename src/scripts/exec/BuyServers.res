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
  let maxRam = ns->NS.getPurchasedServerMaxRam

  if flags["help"] {
    ns->NS.tprint("Buys servers.
--ram int : Servers' RAM, must be a power of 2.
--count int : How many servers to buy. If not specified, buys servers as many as possible.
--prefix string : Servers' hostname prefix. Defaults to 'myserver'.
--continuous : Buys servers continuously.
--dry : Only prints the info of buying servers, does not actually buy.")
  } else if (
    !(ram->Helpers.isInteger && ram > 0.0 && Math.log2(ram)->Helpers.isInteger && ram <= maxRam)
  ) {
    let ramString = if ram->Float.isNaN {
      ""
    } else {
      " : " ++ ns->NS.formatRam(ram)
    }
    ns->NS.tprint(
      `ERROR: servers' RAM is missing, not an integer, less than 1, not a power of 2 or greater than the max RAM ${ns->NS.formatRam(
          maxRam,
        )}${ramString}`,
    )
  } else if !(count->Float.isNaN || (count->Helpers.isInteger && count > 0.0)) {
    ns->NS.tprint(
      `ERROR: servers' count to buy is not an integer or less than 1: ${count->Float.toString}`,
    )
  } else {
    let maxCount = ns->NS.getPurchasedServerLimit - ns->NS.getPurchasedServers->Array.length
    let buyCount = if count->Float.isNaN {
      maxCount
    } else {
      Js.Math.min_int(count->Float.toInt, maxCount)
    }
    if !(count->Float.isNaN) && buyCount !== count->Float.toInt {
      ns->NS.tprint(
        `INFO: max count is ${buyCount->Int.toString}, less than the count argument ${count->Float.toString}`,
      )
    }

    ns->NS.tprint(`INFO: the RAM of purchased servers: ${ns->NS.formatRam(ram)}`)
    ns->NS.tprint(`INFO: the count of servers to buy: ${buyCount->Int.toString}`)
    let singleCost = ns->NS.getPurchasedServerCost(ram)
    ns->NS.tprint(
      `INFO: a single server's cost: ${ns->NS.formatMoney(
          singleCost,
        )} , full cost: ${ns->NS.formatMoney(singleCost *. buyCount->Int.toFloat)}`,
    )

    if !dry && ram > 0.0 && buyCount > 0 {
      let n = ref(0)
      let shouldContinue = ref(true)
      let breakOrSleep = async () => {
        if continuous {
          (await ns->NS.asleep(60000.0))->ignore
        } else {
          shouldContinue := false
        }
      }

      while n.contents < buyCount && shouldContinue.contents {
        if ns->NS.getPlayerMoney >= singleCost {
          if (
            ns->NS.purchaseServer(`${prefix}-${n.contents->Int.toString}`, ram)->String.length > 0
          ) {
            n := n.contents + 1
          } else {
            ns->NS.print("ERROR: failed to buy a server")
            await breakOrSleep()
          }
        } else {
          await breakOrSleep()
        }
      }
    } else {
      ns->NS.tprint(`INFO: no servers to buy`)
    }
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let args = args->Flags.argsToStrings

  if !(args->Flags.argsHasHelp) {
    switch args->Array.at(-1) {
    | Some("--ram") | Some("--count") | Some("--prefix") => ()
    | _ => Flags.schemaToFlagsExn(data.flags, schema)->ignore
    }
  }

  []
}
