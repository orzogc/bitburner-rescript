/*** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.md> */

open NSTypes

type t

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.creategang.md> */
@send
external createGang: (t, gangFactionName) => bool = "createGang"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.ingang.md> */
@send
external inGang: t => bool = "inGang"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getmembernames.md> */
@send
external getMemberNames: t => array<gangMemberName> = "getMemberNames"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.renamemember.md> */
@send
external renameMember: (t, gangMemberName, ~newName: gangMemberName) => bool = "renameMember"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getganginformation.md> */
@send
external getGangInformation: t => gangGenInfo = "getGangInformation"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getotherganginformation.md> */
@send
external getOtherGangInformation: t => Dict.t<gangOtherInfoObject> = "getOtherGangInformation"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getmemberinformation.md> */
@send
external getMemberInformation: (t, gangMemberName) => gangMemberInfo = "getMemberInformation"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.canrecruitmember.md> */
@send
external canRecruitMember: t => bool = "canRecruitMember"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getrecruitsavailable.md> */
@send
external getRecruitsAvailable: t => int = "getRecruitsAvailable"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.respectfornextrecruit.md> */
@send
external respectForNextRecruit: t => respect = "respectForNextRecruit"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.recruitmember.md> */
@send
external recruitMember: (t, gangMemberName) => bool = "recruitMember"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.gettasknames.md> */
@send
external getTaskNames: t => array<gangTaskName> = "getTaskNames"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.setmembertask.md> */
@send
external setMemberTask: (t, gangMemberName, gangTaskName) => bool = "setMemberTask"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.gettaskstats.md> */
@send
external getTaskStats: (t, gangTaskName) => gangTaskStats = "getTaskStats"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getequipmentnames.md> */
@send
external getEquipmentNames: t => array<gangEquipmentName> = "getEquipmentNames"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getequipmentcost.md> */
@send
external getEquipmentCost: (t, gangEquipmentName) => money = "getEquipmentCost"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getequipmenttype.md> */
@send
external getEquipmentType: (t, gangEquipmentName) => gangEquipmentType = "getEquipmentType"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getequipmentstats.md> */
@send
external getEquipmentStats: (t, gangEquipmentName) => equipmentStats = "getEquipmentStats"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.purchaseequipment.md> */
@send
external purchaseEquipment: (t, gangMemberName, gangEquipmentName) => bool = "purchaseEquipment"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.ascendmember.md> */
@send
external ascendMember: (t, gangMemberName) => option<gangMemberAscension> = "ascendMember"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getascensionresult.md> */
@send
external getAscensionResult: (t, gangMemberName) => option<gangMemberAscension> =
  "getAscensionResult"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.setterritorywarfare.md> */
@send
external setTerritoryWarfare: (t, bool) => unit = "setTerritoryWarfare"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getchancetowinclash.md> */
@send
external getChanceToWinClash: (t, gangFactionName) => chance = "getChanceToWinClash"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.getbonustime.md> */
@send
external getBonusTime: t => milliseconds = "getBonusTime"

/** <https://github.com/bitburner-official/bitburner-src/blob/dev/markdown/bitburner.gang.nextupdate.md> */
@send
external nextUpdate: t => promise<milliseconds> = "nextUpdate"
