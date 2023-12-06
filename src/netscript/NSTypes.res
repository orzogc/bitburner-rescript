type host = string

type ip = string

type money = float

type skillLevel = int

type experience = float

type threads = int

type decimalThreads = float

type cores = int

type multiplier = float

type pid = int

type ram = float

type securityLevel = float

type milliseconds = float

type seconds = float

type functionName = string

type file = string

type port = int

type data = string

type size = float

type coordinate = float

type chance = float

type weight = float

type factor = float

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.scriptarg.md> */
@unboxed
type scriptArg = StringArg(string) | NumberArg(float) | BoolArg(bool)

@unboxed
type scriptFlag = StringFlag(string) | NumberFlag(float) | BoolFlag(bool) | ArrayFlag(array<string>)

type sleepReturn = | @as(true) SleepReturn

/* /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.filenameorpid.md> */
@unboxed
type filenameOrPID = Filename(file) | PID(pid) */

type writeFileMode = | @as("w") Overwrite | @as("a") Append

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.portdata.md> */
@unboxed
type portData = StringData(data) | NumberData(float)

type toastVariant =
  | @as("success") Success | @as("warning") Warning | @as("error") Error | @as("info") Info

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.cityname.md> */
type cityName = Aevum | Chongqing | Sector12 | NewTokyo | Ishima | Volhaven

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.companyname.md> */
type companyName =
  | ECorp
  | MegaCorp
  | @as("Bachman & Associates") BachmanAndAssociates
  | @as("Blade Industries") BladeIndustries
  | NWO
  | @as("Clarke Incorporated") ClarkeIncorporated
  | @as("OmniTek Incorporated") OmniTekIncorporated
  | @as("Four Sigma") FourSigma
  | @as("KuaiGong International") KuaiGongInternational
  | @as("Fulcrum Technologies") FulcrumTechnologies
  | @as("Storm Technologies") StormTechnologies
  | DefComm
  | @as("Helios Labs") HeliosLabs
  | VitaLife
  | @as("Icarus Microsystems") IcarusMicrosystems
  | @as("Universal Energy") UniversalEnergy
  | @as("Galactic Cybersystems") GalacticCybersystems
  | AeroCorp
  | @as("Omnia Cybersystems") OmniaCybersystems
  | @as("Solaris Space Systems") SolarisSpaceSystems
  | DeltaOne
  | @as("Global Pharmaceuticals") GlobalPharmaceuticals
  | @as("Nova Medical") NovaMedical
  | @as("Central Intelligence Agency") CIA
  | @as("National Security Agency") NSA
  | @as("Watchdog Security") WatchdogSecurity
  | LexoCorp
  | @as("Rho Construction") RhoConstruction
  | @as("Alpha Enterprises") AlphaEnterprises
  | @as("Aevum Police Headquarters") Police
  | @as("SysCore Securities") SysCoreSecurities
  | CompuTek
  | @as("NetLink Technologies") NetLinkTechnologies
  | @as("Carmichael Security") CarmichaelSecurity
  | FoodNStuff
  | @as("Joe's Guns") JoesGuns
  | @as("Omega Software") OmegaSoftware
  | @as("Noodle Bar") NoodleBar

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.jobname.md> */
type jobName =
  | @as("Software Engineering Intern") SoftwareEngineeringIntern
  | @as("Junior Software Engineer") JuniorSoftwareEngineer
  | @as("Senior Software Engineer") SeniorSoftwareEngineer
  | @as("Lead Software Developer") LeadSoftwareDeveloper
  | @as("Head of Software") HeadOfSoftware
  | @as("Head of Engineering") HeadOfEngineering
  | @as("Vice President of Technology") VicePresidentOfTechnology
  | @as("Chief Technology Officer") ChiefTechnologyOfficer
  | @as("IT Intern") ItIntern
  | @as("IT Analyst") ItAnalyst
  | @as("IT Manager") ItManager
  | @as("Systems Administrator") SystemsAdministrator
  | @as("Security Engineer") SecurityEngineer
  | @as("Network Engineer") NetworkEngineer
  | @as("Network Administrator") NetworkAdministrator
  | @as("Business Intern") BusinessIntern
  | @as("Business Analyst") BusinessAnalyst
  | @as("Business Manager") BusinessManager
  | @as("Operations Manager") OperationsManager
  | @as("Chief Financial Officer") ChiefFinancialOfficer
  | @as("Chief Executive Officer") ChiefExecutiveOfficer
  | @as("Security Guard") SecurityGuard
  | @as("Security Officer") SecurityOfficer
  | @as("Security Supervisor") SecuritySupervisor
  | @as("Head of Security") HeadOfSecurity
  | @as("Field Agent") FieldAgent
  | @as("Secret Agent") SecretAgent
  | @as("Special Operative") SpecialOperative
  | @as("Waiter") Waiter
  | @as("Employee") Employee
  | @as("Software Consultant") SoftwareConsultant
  | @as("Senior Software Consultant") SeniorSoftwareConsultant
  | @as("Business Consultant") BusinessConsultant
  | @as("Senior Business Consultant") SeniorBusinessConsultant
  | @as("Part-time Waiter") PartTimeWaiter
  | @as("Part-time Employee") PartTimeEmployee

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.basichgwoptions.md> */
type basicHGWOptions = {
  threads?: threads,
  stock?: bool,
  additionalMsec?: milliseconds,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.tailproperties.md> */
type tailProperties = {
  x: coordinate,
  y: coordinate,
  width: size,
  height: size,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.runningscript.md> */
type runningScript = {
  args: array<scriptArg>,
  filename: file,
  logs: array<string>,
  offlineExpGained: experience,
  offlineMoneyMade: money,
  offlineRunningTime: seconds,
  onlineExpGained: experience,
  onlineMoneyMade: money,
  onlineRunningTime: seconds,
  pid: pid,
  ramUsage: ram,
  server: host,
  tailProperties: Null.t<tailProperties>,
  title: string, // TODO: add ReactElement
  threads: threads,
  temporary: bool,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.recentscript.md> */
type recentScript = {
  ...runningScript,
  timeOfDeath: Date.t,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.runoptions.md> */
type runOptions = {
  threads?: threads,
  temporary?: bool,
  ramOverride?: ram,
  preventDuplicates?: bool,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.spawnoptions.md> */
type spawnOptions = {
  ...runOptions,
  spawnDelay?: milliseconds,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.processinfo.md> */
type processInfo = {
  filename: file,
  threads: threads,
  args: array<scriptArg>,
  pid: pid,
  temporary: bool,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.hackingmultipliers.md> */
type hackingMultipliers = {
  chance: multiplier,
  speed: multiplier,
  money: multiplier,
  growth: multiplier,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.hacknetmultipliers.md> */
type hacknetMultipliers = {
  production: multiplier,
  purchaseCost: multiplier,
  ramCost: multiplier,
  coreCost: multiplier,
  levelCost: multiplier,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.server.md> */
type server = {
  hostname: host,
  ip: ip,
  sshPortOpen: bool,
  ftpPortOpen: bool,
  smtpPortOpen: bool,
  httpPortOpen: bool,
  sqlPortOpen: bool,
  hasAdminRights: bool,
  cpuCores: cores,
  isConnectedTo: bool,
  ramUsed: ram,
  maxRam: ram,
  organizationName: string,
  purchasedByPlayer: bool,
  backdoorInstalled?: bool,
  baseDifficulty?: securityLevel,
  hackDifficulty?: securityLevel,
  minDifficulty?: securityLevel,
  moneyAvailable?: money,
  moneyMax?: money,
  numOpenPortsRequired?: int,
  openPortCount?: int,
  requiredHackingSkill?: skillLevel,
  serverGrowth?: float,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.md> */
type netscriptPort = {
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.write.md> */
  write: portData => Null.t<portData>,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.trywrite.md> */
  tryWrite: portData => bool,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.nextwrite.md> */
  nextWrite: unit => promise<unit>,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.read.md> */
  read: unit => portData,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.peek.md> */
  peek: unit => portData,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.full.md> */
  full: unit => bool,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.empty.md> */
  empty: unit => bool,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.netscriptport.clear.md> */
  clear: unit => unit,
}

type selectType = | @as("select") SelectType

type promptChoices = {
  @as("type") type_: selectType,
  choices: array<string>,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.bitnodemultipliers.md> */
type bitNodeMultipliers = {
  @as("AgilityLevelMultiplier") agilityLevelMultiplier: multiplier,
  @as("AugmentationMoneyCost") augmentationMoneyCost: multiplier,
  @as("AugmentationRepCost") augmentationRepCost: multiplier,
  @as("BladeburnerRank") bladeburnerRank: multiplier,
  @as("BladeburnerSkillCost") bladeburnerSkillCost: multiplier,
  @as("CharismaLevelMultiplier") charismaLevelMultiplier: multiplier,
  @as("ClassGymExpGain") classGymExpGain: multiplier,
  @as("CodingContractMoney") codingContractMoney: multiplier,
  @as("CompanyWorkExpGain") companyWorkExpGain: multiplier,
  @as("CompanyWorkMoney") companyWorkMoney: multiplier,
  @as("CorporationDivisions") corporationDivisions: multiplier,
  @as("CorporationSoftcap") corporationSoftcap: multiplier,
  @as("CorporationValuation") corporationValuation: multiplier,
  @as("CrimeExpGain") crimeExpGain: multiplier,
  @as("CrimeMoney") crimeMoney: multiplier,
  @as("DaedalusAugsRequirement") daedalusAugsRequirement: multiplier,
  @as("DefenseLevelMultiplier") defenseLevelMultiplier: multiplier,
  @as("DexterityLevelMultiplier") dexterityLevelMultiplier: multiplier,
  @as("FactionPassiveRepGain") factionPassiveRepGain: multiplier,
  @as("FactionWorkExpGain") factionWorkExpGain: multiplier,
  @as("FactionWorkRepGain") factionWorkRepGain: multiplier,
  @as("FourSigmaMarketDataApiCost") fourSigmaMarketDataApiCost: multiplier,
  @as("FourSigmaMarketDataCost") fourSigmaMarketDataCost: multiplier,
  @as("GangSoftcap") gangSoftcap: multiplier,
  @as("HackExpGain") hackExpGain: multiplier,
  @as("HackingLevelMultiplier") hackingLevelMultiplier: multiplier,
  @as("HacknetNodeMoney") hacknetNodeMoney: multiplier,
  @as("HomeComputerRamCost") homeComputerRamCost: multiplier,
  @as("InfiltrationMoney") infiltrationMoney: multiplier,
  @as("InfiltrationRep") infiltrationRep: multiplier,
  @as("ManualHackMoney") manualHackMoney: multiplier,
  @as("PurchasedServerCost") purchasedServerCost: multiplier,
  @as("PurchasedServerLimit") purchasedServerLimit: multiplier,
  @as("PurchasedServerMaxRam") purchasedServerMaxRam: multiplier,
  @as("PurchasedServerSoftcap") purchasedServerSoftcap: multiplier,
  @as("RepToDonateToFaction") repToDonateToFaction: multiplier,
  @as("ScriptHackMoney") scriptHackMoney: multiplier,
  @as("ScriptHackMoneyGain") scriptHackMoneyGain: multiplier,
  @as("ServerGrowthRate") serverGrowthRate: multiplier,
  @as("ServerMaxMoney") serverMaxMoney: multiplier,
  @as("ServerStartingMoney") serverStartingMoney: multiplier,
  @as("ServerStartingSecurity") serverStartingSecurity: multiplier,
  @as("ServerWeakenRate") serverWeakenRate: multiplier,
  @as("StrengthLevelMultiplier") strengthLevelMultiplier: multiplier,
  @as("StaneksGiftPowerMultiplier") staneksGiftPowerMultiplier: multiplier,
  @as("StaneksGiftExtraSize") staneksGiftExtraSize: multiplier,
  @as("WorldDaemonDifficulty") worldDaemonDifficulty: multiplier,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.skills.md> */
type skills = {
  hacking: skillLevel,
  strength: skillLevel,
  defense: skillLevel,
  dexterity: skillLevel,
  agility: skillLevel,
  charisma: skillLevel,
  intelligence: skillLevel,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.skills.md> */
type skillsExperience = {
  hacking: experience,
  strength: experience,
  defense: experience,
  dexterity: experience,
  agility: experience,
  charisma: experience,
  intelligence: experience,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.hp.md> */
type hp = {
  current: int,
  max: int,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.multipliers.md> */
type multipliers = {
  hacking: multiplier,
  strength: multiplier,
  defense: multiplier,
  dexterity: multiplier,
  agility: multiplier,
  charisma: multiplier,
  hacking_exp: multiplier,
  strength_exp: multiplier,
  defense_exp: multiplier,
  dexterity_exp: multiplier,
  agility_exp: multiplier,
  charisma_exp: multiplier,
  hacking_chance: multiplier,
  hacking_speed: multiplier,
  hacking_money: multiplier,
  hacking_grow: multiplier,
  company_rep: multiplier,
  faction_rep: multiplier,
  crime_money: multiplier,
  crime_success: multiplier,
  work_money: multiplier,
  hacknet_node_money: multiplier,
  hacknet_node_purchase_cost: multiplier,
  hacknet_node_ram_cost: multiplier,
  hacknet_node_core_cost: multiplier,
  hacknet_node_level_cost: multiplier,
  bladeburner_max_stamina: multiplier,
  bladeburner_stamina_gain: multiplier,
  bladeburner_analysis: multiplier,
  bladeburner_success_chance: multiplier,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.person.md> */
type person = {
  hp: hp,
  skills: skills,
  exp: skillsExperience,
  mults: multipliers,
  city: cityName,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.player.md> */
type player = {
  ...person,
  money: money,
  numPeopleKilled: int,
  entropy: float,
  /** key is companyName */
  jobs: Dict.t<jobName>,
  factions: array<string>,
  totalPlaytime: float, // milliseconds?
  location: string,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.moneysource.md> */
type moneySource = {
  bladeburner: money,
  casino: money,
  class: money,
  codingcontract: money,
  corporation: money,
  crime: money,
  gang: money,
  hacking: money,
  hacknet: money,
  hacknet_expenses: money,
  hospitalization: money,
  infiltration: money,
  sleeves: money,
  stock: money,
  total: money,
  work: money,
  servers: money,
  other: money,
  augmentations: money,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.moneysources.md> */
type moneySources = {
  sinceInstall: moneySource,
  sinceStart: moneySource,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.resetinfo.md> */
type resetInfo = {
  lastAugReset: milliseconds,
  lastNodeReset: milliseconds,
  currentNode: int,
  ownedAugs: Map.t<string, int>,
  ownedSF: Map.t<string, int>,
}

type getFlags = array<(string, scriptFlag)> => Dict.t<scriptFlag>

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.autocompletedata.md> */
type autocompleteData = {
  servers: array<string>,
  scripts: array<string>,
  txts: array<string>,
  /** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.autocompletedata.flags.md> */
  flags: getFlags,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/src/Gang/data/Constants.ts> */
type gangFactionName =
  | @as("Slum Snakes") SlumSnakes
  | Tetrads
  | @as("The Syndicate") TheSyndicate
  | @as("The Dark Army") TheDarkArmy
  | @as("Speakers for the Dead") SpeakersForTheDead
  | NiteSec
  | @as("The Black Hand") TheBlackHand

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/src/Faction/Enums.ts> */
type factionName =
  | ...gangFactionName
  | Illuminati
  | Daedalus
  | @as("The Covenant") TheCovenant
  | ECorp
  | MegaCorp
  | @as("Bachman & Associates") BachmanAssociates
  | @as("Blade Industries") BladeIndustries
  | NWO
  | @as("Clarke Incorporated") ClarkeIncorporated
  | @as("OmniTek Incorporated") OmniTekIncorporated
  | @as("Four Sigma") FourSigma
  | @as("KuaiGong International") KuaiGongInternational
  | @as("Fulcrum Secret Technologies") FulcrumSecretTechnologies
  | BitRunner
  | Aevum
  | Chongqing
  | Ishima
  | @as("New Tokyo") NewTokyo
  | @as("Sector-12") Sector12
  | Volhaven
  | Silhouette
  | Netburners
  | @as("Tian Di Hui") TianDiHui
  | CyberSec
  | Bladeburners
  | @as("Church of the Machine God") ChurchOfTheMachineGod
  | @as("Shadows of Anarchy") ShadowsOfAnarchy

type respect = float

type power = float

type territory = float

type wantedLevel = float

type ascensionPoints = float

type gangMemberName = string

type gangTaskName = string

type gangEquipmentName = string

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.ganggeninfo.md> */
type gangGenInfo = {
  faction: gangFactionName,
  isHacking: bool,
  moneyGainRate: money,
  power: power,
  respect: respect,
  respectGainRate: respect,
  respectForNextRecruit: respect,
  territory: territory,
  territoryClashChance: chance,
  wantedLevel: wantedLevel,
  wantedLevelGainRate: wantedLevel,
  territoryWarfareEngaged: bool,
  wantedPenalty: float,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gangotherinfoobject.md> */
type gangOtherInfoObject = {
  power: power,
  territory: territory,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gangmemberinfo.md> */
type gangMemberInfo = {
  name: gangMemberName,
  task: gangTaskName,
  earnedRespect: respect,
  hack: skillLevel,
  str: skillLevel,
  def: skillLevel,
  dex: skillLevel,
  agi: skillLevel,
  cha: skillLevel,
  hack_exp: experience,
  str_exp: experience,
  def_exp: experience,
  dex_exp: experience,
  agi_exp: experience,
  cha_exp: experience,
  hack_mult: multiplier,
  str_mult: multiplier,
  def_mult: multiplier,
  dex_mult: multiplier,
  agi_mult: multiplier,
  cha_mult: multiplier,
  hack_asc_mult: multiplier,
  str_asc_mult: multiplier,
  def_asc_mult: multiplier,
  dex_asc_mult: multiplier,
  agi_asc_mult: multiplier,
  cha_asc_mult: multiplier,
  hack_asc_points: ascensionPoints,
  str_asc_points: ascensionPoints,
  def_asc_points: ascensionPoints,
  dex_asc_points: ascensionPoints,
  agi_asc_points: ascensionPoints,
  cha_asc_points: ascensionPoints,
  upgrades: array<gangEquipmentName>,
  augmentations: array<gangEquipmentName>,
  respectGain: respect,
  wantedLevelGain: wantedLevel,
  moneyGain: money,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gangterritory.md> */
type gangTerritory = {
  money: float,
  respect: float,
  wanted: float,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gangtaskstats.md> */
type gangTaskStats = {
  name: gangTaskName,
  desc: string,
  isHacking: bool,
  isCombat: bool,
  baseRespect: respect,
  baseWanted: wantedLevel,
  baseMoney: money,
  hackWeight: weight,
  strWeight: weight,
  defWeight: weight,
  dexWeight: weight,
  agiWeight: weight,
  chaWeight: weight,
  difficulty: float,
  territory: gangTerritory,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/src/Gang/GangMemberUpgrade.ts> */
type gangEquipmentType = Weapon | Armor | Vehicle | Rootkit | Augmentation

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.equipmentstats.md> */
type equipmentStats = {
  str?: multiplier,
  def?: multiplier,
  dex?: multiplier,
  agi?: multiplier,
  cha?: multiplier,
  hack?: multiplier,
}

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gangmemberascension.md> */
type gangMemberAscension = {
  respect: respect,
  hack: factor,
  str: factor,
  def: factor,
  dex: factor,
  agi: factor,
  cha: factor,
}
