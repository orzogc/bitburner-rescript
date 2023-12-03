type error = [#notHackableServer | #calculationFailure]

let weakenThreads = (ns, target, cores, ~weakenSecurity=?) => {
  let info = ns->NS.getServer(~host=target)

  switch (info.hackDifficulty, info.minDifficulty) {
  | (Some(security), Some(minSecurity)) => {
      let toWeaken = weakenSecurity->Option.getOr(security -. minSecurity)

      if toWeaken > 0.0 {
        let singleWeaken = ns->NS.weakenAnalyze(1, ~cores)

        if singleWeaken > 0.0 {
          Ok(((toWeaken +. 0.001) /. singleWeaken)->Js.Math.ceil_int)
        } else {
          Error(#calculationFailure)
        }
      } else {
        Ok(0)
      }
    }
  | _ => Error(#notHackableServer)
  }
}

let growThreads = (ns, target, cores, ~multiplier=?) => {
  let info = ns->NS.getServer(~host=target)

  switch (info.moneyAvailable, info.moneyMax) {
  | (Some(money), Some(maxMoney)) =>
    if money > 0.0 {
      let toGrow = multiplier->Option.getOr(maxMoney /. money)

      if toGrow > 1.0 {
        let threads = ns->NS.growthAnalyze(target, toGrow +. 0.001, ~cores)

        if threads > 0.0 {
          Ok(threads->Js.Math.ceil_int)
        } else {
          Error(#calculationFailure)
        }
      } else {
        Ok(0)
      }
    } else {
      Ok(1000)
    }
  | _ => Error(#notHackableServer)
  }
}

let hackThreads = (ns, target, ~hackMoney=?) => {
  let info = ns->NS.getServer(~host=target)

  switch info.moneyAvailable {
  | Some(money) => {
      let toHack = hackMoney->Option.getOr(money *. 0.5)

      if toHack >= 0.0 && toHack <= money {
        let threads = ns->NS.hackAnalyzeThreads(target, toHack)

        if threads >= 0.0 {
          Ok(threads->Js.Math.ceil_int)
        } else {
          Error(#calculationFailure)
        }
      } else {
        Error(#calculationFailure)
      }
    }
  | _ => Error(#notHackableServer)
  }
}
