let schema = {
  "target": "",
  "script": "",
  "threads": nan,
  "percentage": nan,
  "upload": false,
  "help": false,
}

let main: NS.main = async ns => {
  let (flags, args) = ns->Flags.getFlagsExn(schema)
  let target = flags["target"]
  let script = flags["script"]
  let threads = flags["threads"]
  let percentage = flags["percentage"]
  let upload = flags["upload"]

  if flags["help"] {
    ns->NS.tprint("Runs a script on target servers.
--target string : Targer servers, can be 'allServers', 'purchasedServers', 'allServersExcludePurchasedServers' (these all excludes home server) or servers' hostnames separated by comma.
--script string : Script to run.
--threads int : An integer which is greater or equal to 1. Runs the script by specified threads.
--percentage float : A float which is greater than 0 and less than 1. Runs the script using specified percentage of free memory.
--upload : Whether uploads the script on current server to target server.
Other arguments are passed to the script.
If threads and percentage are not specified, runs the script by max threads.
Threads and percentage must not be used at the same time.")
  } else if target->String.length === 0 {
    ns->NS.tprint("ERROR: no target in flags")
  } else if script->String.length === 0 {
    ns->NS.tprint("ERROR: no script in flags")
  } else if !(threads->Float.isNaN || (threads->Helpers.isInteger && threads >= 1.0)) {
    ns->NS.tprint("ERROR: threads must be an integer which is greater or equal to 1")
  } else if !(percentage->Float.isNaN || (percentage > 0.0 && percentage < 1.0)) {
    ns->NS.tprint("ERROR: percentage must be a float which is greater than 0 and less than 1")
  } else if !(threads->Float.isNaN) && !(percentage->Float.isNaN) {
    ns->NS.tprint("ERROR: threads and percentage must not be used at the same time.")
  } else {
    let threads = if threads->Helpers.isInteger && threads >= 1.0 {
      Some(threads->Float.toInt)
    } else {
      None
    }
    let percentage = if percentage > 0.0 && percentage < 1.0 {
      Some(percentage)
    } else {
      None
    }
    let servers = if target === "allServers" {
      ns->Helpers.crawlServers
    } else if target === "purchasedServers" {
      Set.fromArray(ns->NS.getPurchasedServers)
    } else if target === "allServersExcludePurchasedServers" {
      ns->Helpers.crawlServers(~excludePurchasedServers=true)
    } else {
      Set.fromArray(target->String.split(","))
    }

    servers->Set.forEach(server =>
      switch ns->Helpers.execScript(server, script, ~threads?, ~percentage?, ~upload, ~args) {
      | Ok(_) => ()
      | Error(e) => ns->NS.tprint2(`ERROR: failed to run script ${script} on server ${server}: `, e)
      }
    )
  }
}

let autocomplete: NS.autocomplete = (data, args) => {
  let setFlags = () => Flags.schemaToFlagsExn(data.flags, schema)->ignore
  let args = args->Flags.argsToStrings

  if args->Flags.argsHasHelp {
    []
  } else {
    switch args->Array.at(-2) {
    | Some("--target") | Some("--script") | Some("--threads") | Some("--percentage") => setFlags()
    | _ => ()
    }

    switch (args->Array.at(-2), args->Array.at(-1)) {
    | (Some("--target"), _) | (_, Some("--target")) => {
        let arguments = data.servers->Array.copy
        arguments->Array.pushMany([
          "allServers",
          "purchasedServers",
          "allServersExcludePurchasedServers",
        ])

        arguments
      }
    | (Some("--script"), _) | (_, Some("--script")) => data.scripts
    | (Some("--threads"), _)
    | (_, Some("--threads"))
    | (Some("--percentage"), _)
    | (_, Some("--percentage")) => []
    | _ => {
        setFlags()

        []
      }
    }
  }
}
