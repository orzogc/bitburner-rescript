/*** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.md> */

open NSTypes

type t

type main = t => promise<unit>

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.args.md> */
@get
external args: t => array<scriptArg> = "args"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.pid.md> */
@get
external pid: t => pid = "pid"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hack.md> */
@send
external hack: (t, host, ~opts: basicHGWOptions=?) => promise<money> = "hack"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.grow.md> */
@send
external grow: (t, host, ~opts: basicHGWOptions=?) => promise<multiplier> = "grow"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.weaken.md> */
@send
external weaken: (t, host, ~opts: basicHGWOptions=?) => promise<securityLevel> = "weaken"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.weakenanalyze.md> */
@send
external weakenAnalyze: (t, threads, ~cores: cores=?) => securityLevel = "weakenAnalyze"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hackanalyzethreads.md> */
@send
external hackAnalyzeThreads: (t, host, money) => decimalThreads = "hackAnalyzeThreads"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hackanalyze.md> */
@send
external hackAnalyze: (t, host) => money = "hackAnalyze"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hackanalyzesecurity.md> */
@send
external hackAnalyzeSecurity: (t, threads, ~host: host=?) => securityLevel = "hackAnalyzeSecurity"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hackanalyzechance.md> */
@send
external hackAnalyzeChance: (t, host) => float = "hackAnalyzeChance"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.growthanalyze.md> */
@send
external growthAnalyze: (t, host, multiplier, ~cores: cores=?) => decimalThreads = "growthAnalyze"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.growthanalyzesecurity.md> */
@send
external growthAnalyzeSecurity: (t, threads, ~host: host=?, ~cores: cores=?) => securityLevel =
  "growthAnalyzeSecurity"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sleep.md> */
@send
external sleep: (t, milliseconds) => promise<sleepReturn> = "sleep"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.asleep.md> */
@send
external asleep: (t, milliseconds) => promise<sleepReturn> = "asleep"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.print.md> */
@send
external print: (t, 'a) => unit = "print"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.print.md> */
@send
external print2: (t, 'a, 'b) => unit = "print"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.print.md> */
@send
external print3: (t, 'a, 'b, 'c) => unit = "print"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.print.md> */
@send
@variadic
external printMany: (t, array<'a>) => unit = "print"

// TODO: printRaw

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.printf.md> */
@send
external printf: (t, string, 'a) => unit = "printf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.printf.md> */
@send
external printf2: (t, string, 'a, 'b) => unit = "printf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.printf.md> */
@send
external printf3: (t, string, 'a, 'b, 'c) => unit = "printf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.printf.md> */
@send
external printf4: (t, string, 'a, 'b, 'c, 'd) => unit = "printf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.printf.md> */
@send
external printf5: (t, string, 'a, 'b, 'c, 'd, 'e) => unit = "printf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.printf.md> */
@send
@variadic
external printfMany: (t, string, array<'a>) => unit = "printf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprint.md> */
@send
external tprint: (t, 'a) => unit = "tprint"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprint.md> */
@send
external tprint2: (t, 'a, 'b) => unit = "tprint"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprint.md> */
@send
external tprint3: (t, 'a, 'b, 'c) => unit = "tprint"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprint.md> */
@send
@variadic
external tprintMany: (t, array<'a>) => unit = "tprint"

// TODO: tprintRaw

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprintf.md> */
@send
external tprintf: (t, string, 'a) => unit = "tprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprintf.md> */
@send
external tprintf2: (t, string, 'a, 'b) => unit = "tprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprintf.md> */
@send
external tprintf3: (t, string, 'a, 'b, 'c) => unit = "tprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprintf.md> */
@send
external tprintf4: (t, string, 'a, 'b, 'c, 'd) => unit = "tprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprintf.md> */
@send
external tprintf5: (t, string, 'a, 'b, 'c, 'd, 'e) => unit = "tprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tprintf.md> */
@send
@variadic
external tprintfMany: (t, string, array<'a>) => unit = "tprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.clearlog.md> */
@send
external clearLog: t => unit = "clearLog"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.disablelog.md> */
@send
external disableLog: (t, functionName) => unit = "disableLog"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.disablelog.md> */
@send
external disableAllLog: (t, @as("ALL") _) => unit = "disableLog"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.enablelog.md> */
@send
external enableLog: (t, functionName) => unit = "enableLog"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.enablelog.md> */
@send
external enableAllLog: (t, @as("ALL") _) => unit = "enableLog"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.islogenabled.md> */
@send
external isLogEnabled: (t, functionName) => bool = "isLogEnabled"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.islogenabled.md> */
@send
external isAllLogEnabled: (t, @as("ALL") _) => bool = "isLogEnabled"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptlogs.md> */
@send
@variadic
external getScriptLogs: (t, file, ~host: host=?, ~args: array<scriptArg>) => array<string> =
  "getScriptLogs"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptlogs.md> */
@send
external getScriptLogsByPID: (t, pid) => array<string> = "getScriptLogs"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptlogs.md> */
@send
external getCurrentScriptLogs: t => array<string> = "getScriptLogs"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getrecentscripts.md> */
@send
external getRecentScripts: t => array<recentScript> = "getRecentScripts"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tail.md> */
@send
@variadic
external tail: (t, file, ~host: host=?, ~args: array<scriptArg>) => unit = "tail"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tail.md> */
@send
external tailByPID: (t, pid) => unit = "tail"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tail.md> */
@send
external tailCurrentScript: t => unit = "tail"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.movetail.md> */
@send
external moveTail: (t, ~x: coordinate, ~y: coordinate, ~pid: pid=?) => unit = "moveTail"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.resizetail.md> */
@send
external resizeTail: (t, ~width: size, ~height: size, ~pid: pid=?) => unit = "resizeTail"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.closetail.md> */
@send
external closeTail: (t, ~pid: pid=?) => unit = "closeTail"

// TODO: add ReactElement
/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.settitle.md> */
@send
external setTitle: (t, string, ~pid: pid=?) => unit = "setTitle"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.scan.md> */
@send
external scan: (t, ~host: host=?) => array<host> = "scan"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hastorrouter.md> */
@send
external hasTorRouter: t => bool = "hasTorRouter"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.nuke.md> */
@send
external nuke: (t, host) => unit = "nuke"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.brutessh.md> */
@send
external brutessh: (t, host) => unit = "brutessh"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.ftpcrack.md> */
@send
external ftpcrack: (t, host) => unit = "ftpcrack"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.relaysmtp.md> */
@send
external relaysmtp: (t, host) => unit = "relaysmtp"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.httpworm.md> */
@send
external httpworm: (t, host) => unit = "httpworm"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sqlinject.md> */
@send
external sqlinject: (t, host) => unit = "sqlinject"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.run.md> */
@send
@variadic
external run: (t, file, ~threads: threads=?, ~args: array<scriptArg>) => pid = "run"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.run.md> */
@send
@variadic
external runWithOptions: (t, file, ~options: runOptions=?, ~args: array<scriptArg>) => pid = "run"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.exec.md> */
@send
@variadic
external exec: (t, file, host, ~threads: threads=?, ~args: array<scriptArg>) => pid = "exec"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.exec.md> */
@send
@variadic
external execWithOptions: (t, file, host, ~options: runOptions=?, ~args: array<scriptArg>) => pid =
  "exec"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.spawn.md> */
@send
@variadic
external spawn: (t, file, ~threads: threads=?, ~args: array<scriptArg>) => unit = "spawn"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.spawn.md> */
@send
@variadic
external spawnWithOptions: (t, file, ~options: spawnOptions=?, ~args: array<scriptArg>) => unit =
  "spawn"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.kill.md> */
@send
external killByPID: (t, pid) => bool = "kill"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.kill_1.md> */
@send
@variadic
external kill: (t, file, ~host: host=?, ~args: array<scriptArg>) => bool = "kill"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.killall.md> */
@send
external killall: (t, ~host: host=?, ~safetyguard: bool=?) => bool = "killall"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.exit.md> */
@send
external exit: t => unit = "exit"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.scp.md> */
@send
external scp: (t, file, host, ~source: host=?) => bool = "scp"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.scp.md> */
@send
external scpFiles: (t, array<file>, host, ~source: host=?) => bool = "scp"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.ls.md> */
@send
external ls: (t, host, ~substring: string=?) => array<file> = "ls"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.ps.md> */
@send
external ps: (t, ~host: host=?) => array<processInfo> = "ps"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.hasrootaccess.md> */
@send
external hasRootAccess: (t, host) => bool = "hasRootAccess"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gethostname.md> */
@send
external getHostname: t => host = "getHostname"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gethackinglevel.md> */
@send
external getHackingLevel: t => skillLevel = "getHackingLevel"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gethackingmultipliers.md> */
@send
external getHackingMultipliers: t => hackingMultipliers = "getHackingMultipliers"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gethacknetmultipliers.md> */
@send
external getHacknetMultipliers: t => hacknetMultipliers = "getHacknetMultipliers"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserver.md> */
@send
external getServer: (t, ~host: host=?) => server = "getServer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserver.md> */
@send
external getHomeServer: (t, @as("home") _) => server = "getServer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getservermoneyavailable.md> */
@send
external getServerMoneyAvailable: (t, host) => money = "getServerMoneyAvailable"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getservermoneyavailable.md> */
@send
external getPlayerMoney: (t, @as("home") _) => money = "getServerMoneyAvailable"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getservermaxmoney.md> */
@send
external getServerMaxMoney: (t, host) => money = "getServerMaxMoney"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getservergrowth.md> */
@send
external getServerGrowth: (t, host) => float = "getServerGrowth"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserversecuritylevel.md> */
@send
external getServerSecurityLevel: (t, host) => securityLevel = "getServerSecurityLevel"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserverminsecuritylevel.md> */
@send
external getServerMinSecurityLevel: (t, host) => securityLevel = "getServerMinSecurityLevel"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserverbasesecuritylevel.md> */
@send
external getServerBaseSecurityLevel: (t, host) => securityLevel = "getServerBaseSecurityLevel"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getservermaxram.md> */
@send
external getServerMaxRam: (t, host) => ram = "getServerMaxRam"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserverusedram.md> */
@send
external getServerUsedRam: (t, host) => ram = "getServerUsedRam"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getserverrequiredhackinglevel.md> */
@send
external getServerRequiredHackingLevel: (t, host) => skillLevel = "getServerRequiredHackingLevel"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getservernumportsrequired.md> */
@send
external getServerNumPortsRequired: (t, host) => int = "getServerNumPortsRequired"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.serverexists.md> */
@send
external serverExists: (t, host) => bool = "serverExists"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.fileexists.md> */
@send
external fileExists: (t, file, ~host: host=?) => bool = "fileExists"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.isrunning.md> */
@send
@variadic
external isRunning: (t, file, ~host: host=?, ~args: array<scriptArg>) => bool = "isRunning"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.isrunning.md> */
@send
external isRunningByPID: (t, pid) => bool = "isRunning"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getrunningscript.md> */
@send
@variadic
@return(null_to_opt)
external getRunningScript: (
  t,
  file,
  ~host: host=?,
  ~args: array<scriptArg>,
) => option<runningScript> = "getRunningScript"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getrunningscript.md> */
@send
@return(null_to_opt)
external getRunningScriptByPID: (t, pid) => option<runningScript> = "getRunningScript"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getrunningscript.md> */
@send
external getCurrentScript: t => runningScript = "getRunningScript"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getpurchasedservercost.md> */
@send
external getPurchasedServerCost: (t, ram) => money = "getPurchasedServerCost"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.purchaseserver.md> */
@send
external purchaseServer: (t, host, ram) => host = "purchaseServer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getpurchasedserverupgradecost.md> */
@send
external getPurchasedServerUpgradeCost: (t, host, ram) => money = "getPurchasedServerUpgradeCost"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.upgradepurchasedserver.md> */
@send
external upgradePurchasedServer: (t, host, ram) => bool = "upgradePurchasedServer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.renamepurchasedserver.md> */
@send
external renamePurchasedServer: (t, ~oldName: host, ~newName: host) => bool =
  "renamePurchasedServer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.deleteserver.md> */
@send
external deleteServer: (t, host) => bool = "deleteServer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getpurchasedservers.md> */
@send
external getPurchasedServers: t => array<host> = "getPurchasedServers"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getpurchasedserverlimit.md> */
@send
external getPurchasedServerLimit: t => int = "getPurchasedServerLimit"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getpurchasedservermaxram.md> */
@send
external getPurchasedServerMaxRam: t => ram = "getPurchasedServerMaxRam"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.write.md> */
@send
external write: (t, file, ~data: data=?, ~mode: writeFileMode=?) => unit = "write"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.trywriteport.md> */
@send
external tryWritePort: (t, port, data) => bool = "tryWritePort"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.trywriteport.md> */
@send
external tryWritePortWithNumber: (t, port, float) => bool = "tryWritePort"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.read.md> */
@send
external read: (t, file) => data = "read"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.peek.md> */
@send
external peek: (t, port) => portData = "peek"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.clear.md> */
@send
external clear: (t, file) => unit = "clear"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.clearport.md> */
@send
external clearPort: (t, port) => unit = "clearPort"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.writeport.md> */
@send
@return(null_to_opt)
external writePort: (t, port, data) => option<portData> = "writePort"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.readport.md> */
@send
external readPort: (t, port) => portData = "readPort"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getporthandle.md> */
@send
external getPortHandle: (t, port) => netscriptPort = "getPortHandle"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.rm.md> */
@send
external rm: (t, file, ~host: host=?) => bool = "rm"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.scriptrunning.md> */
@send
external scriptRunning: (t, file, host) => bool = "scriptRunning"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.scriptkill.md> */
@send
external scriptKill: (t, file, host) => bool = "scriptKill"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptname.md> */
@send
external getScriptName: t => file = "getScriptName"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptram.md> */
@send
external getScriptRam: (t, file, ~host: host=?) => ram = "getScriptRam"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gethacktime.md> */
@send
external getHackTime: (t, host) => milliseconds = "getHackTime"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getgrowtime.md> */
@send
external getGrowTime: (t, host) => milliseconds = "getGrowTime"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getweakentime.md> */
@send
external getWeakenTime: (t, host) => milliseconds = "getWeakenTime"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gettotalscriptincome.md> */
@send
external getTotalScriptIncome: t => (money, money) = "getTotalScriptIncome"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptincome.md> */
@send
@variadic
external getScriptIncome: (t, file, host, array<scriptArg>) => money = "getScriptIncome"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gettotalscriptexpgain.md> */
@send
external getTotalScriptExpGain: t => experience = "getTotalScriptExpGain"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getscriptexpgain.md> */
@send
@variadic
external getScriptExpGain: (t, file, host, array<scriptArg>) => experience = "getScriptExpGain"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.gettimesincelastaug.md> */
@send
external getTimeSinceLastAug: t => milliseconds = "getTimeSinceLastAug"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sprintf.md> */
@send
external sprintf: (t, string, 'a) => string = "sprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sprintf.md> */
@send
external sprintf2: (t, string, 'a, 'b) => string = "sprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sprintf.md> */
@send
external sprintf3: (t, string, 'a, 'b, 'c) => string = "sprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sprintf.md> */
@send
external sprintf4: (t, string, 'a, 'b, 'c, 'd) => string = "sprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sprintf.md> */
@send
external sprintf5: (t, string, 'a, 'b, 'c, 'd, 'e) => string = "sprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.sprintf.md> */
@send
@variadic
external sprintfMany: (t, string, array<'a>) => string = "sprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.vsprintf.md> */
@send
external vsprintf: (t, string, array<'a>) => string = "vsprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.vsprintf.md> */
@send
external vsprintf2: (t, string, ('a, 'b)) => string = "vsprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.vsprintf.md> */
@send
external vsprintf3: (t, string, ('a, 'b, 'c)) => string = "vsprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.vsprintf.md> */
@send
external vsprintf4: (t, string, ('a, 'b, 'c, 'd)) => string = "vsprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.vsprintf.md> */
@send
external vsprintf5: (t, string, ('a, 'b, 'c, 'd, 'e)) => string = "vsprintf"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.formatnumber.md> */
@send
external formatNumber: (
  t,
  float,
  ~fractionalDigits: int=?,
  ~suffixStart: int=?,
  ~isInteger: bool=?,
) => string = "formatNumber"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.formatram.md> */
@send
external formatRam: (t, float, ~fractionalDigits: int=?) => string = "formatRam"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.formatpercent.md> */
@send
external formatPercent: (t, float, ~fractionalDigits: int=?, ~suffixStart: int=?) => string =
  "formatPercent"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.tformat.md> */
@send
external tFormat: (t, milliseconds, ~milliPrecision: bool=?) => string = "tFormat"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.prompt.md> */
@send
external promptBooleanDialog: (t, string) => promise<bool> = "prompt"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.prompt.md> */
@send
external promptTextInputDialog: (t, string, @as(json`{"type":"text"}`) _) => promise<string> =
  "prompt"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.prompt.md> */
@send
external promptSelectDialog: (t, string, promptChoices) => promise<string> = "prompt"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.alert.md> */
@send
external alert: (t, string) => unit = "alert"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.toast.md> */
@send
external toast: (t, string, ~variant: toastVariant=?, ~duration: milliseconds=?) => unit = "toast"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.toast.md> */
@send
external persistentToast: (t, string, ~variant: toastVariant=?, @as(json`null`) _) => unit = "toast"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.wget.md> */
@send
external wget: (t, string, file, ~host: host=?) => promise<bool> = "wget"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getfavortodonate.md> */
@send
external getFavorToDonate: t => int = "getFavorToDonate"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getbitnodemultipliers.md> */
@send
external getBitNodeMultipliers: (t, ~n: float=?, ~lvl: float=?) => bitNodeMultipliers =
  "getBitNodeMultipliers"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getplayer.md> */
@send
external getPlayer: t => player = "getPlayer"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getmoneysources.md> */
@send
external getMoneySources: t => moneySources = "getMoneySources"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.atexit.md> */
@send
external atExit: (t, unit => unit) => unit = "atExit"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.mv.md> */
@send
external mv: (t, host, ~source: file, ~destination: file) => unit = "mv"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getresetinfo.md> */
@send
external getResetInfo: t => resetInfo = "getResetInfo"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getfunctionramcost.md> */
@send
external getFunctionRamCost: (t, functionName) => ram = "getFunctionRamCost"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.flags.md> */
@send
external flags: (t, array<(string, scriptFlag)>) => Dict.t<scriptFlag> = "flags"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.flags.md> */
@send
external flagsUnsafe: (t, array<(string, scriptFlag)>) => 'a = "flags"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.share.md> */
@send
external share: t => promise<unit> = "share"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ns.getsharepower.md> */
@send
external getSharePower: t => multiplier = "getSharePower"
