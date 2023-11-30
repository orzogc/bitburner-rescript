type error = [#notHackableServer]

let weakenThreads = (ns, host) => {
  let info = ns->NS.getServer(~host)

  switch (info.hackDifficulty, info.minDifficulty) {
  | (Some(security), Some(minSecurity)) => {
      let toWeaken = security -. minSecurity

      if toWeaken > 0.0 {
        let singleWeaken = ns->NS.weakenAnalyze(1, ~cores=ns->Helpers.getHomeCores)

        Ok((toWeaken /. singleWeaken)->Js.Math.ceil_int)
      } else {
        Ok(0)
      }
    }
  | _ => Error(#notHackableServer)
  }
}
