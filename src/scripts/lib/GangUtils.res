let ascend = (ns, memberName, ~buyOwnedEquipments=true) => {
  let gang = ns->NS.gang
  let equipments = (gang->Gang.getMemberInformation(memberName)).upgrades

  switch gang->Gang.ascendMember(memberName) {
  | Some(_) => {
      if buyOwnedEquipments {
        equipments->Array.forEach(equipment =>
          if !(gang->Gang.purchaseEquipment(memberName, equipment)) {
            ns->NS.print(`ERROR: falied to buy equipment ${equipment} to ${memberName}`)
          }
        )
      }

      true
    }
  | None => false
  }
}

let ascendAndBuyEquipments = async (ns, memberName) => {
  let gang = ns->NS.gang
  let canContinue = ref(true)
  let result = ref(false)

  while canContinue.contents {
    let cost =
      (gang->Gang.getMemberInformation(memberName)).upgrades->Array.reduce(0.0, (c, equipment) =>
        c +. gang->Gang.getEquipmentCost(equipment)
      )

    if ns->NS.getPlayerMoney >= cost {
      result := ns->ascend(memberName, ~buyOwnedEquipments=true)
      canContinue := false
    } else {
      ns->NS.print(
        `INFO: waiting for enough money ${cost->Float.toString} to buy equipments to ${memberName}`,
      )
      await ns->Helpers.sleep(60000)
    }
  }

  result.contents
}

type trainType = Combat | Hacking | Charisma

let trainTypeToString = trainType =>
  switch trainType {
  | Combat => "Train Combat"
  | Hacking => "Train Hacking"
  | Charisma => "Train Charisma"
  }

let train = async (ns, memberName, trainType, ~milliseconds=300000) => {
  let gang = ns->NS.gang
  let trainType = trainType->trainTypeToString
  let taskNames = gang->Gang.getTaskNames
  let oldTask = (gang->Gang.getMemberInformation(memberName)).task

  if (
    taskNames->Array.some(task => task === trainType) &&
      taskNames->Array.some(task => task === oldTask)
  ) {
    ns->NS.print(`INFO: start training ${memberName}: ${trainType}`)

    if gang->Gang.setMemberTask(memberName, trainType) {
      await ns->Helpers.sleep(milliseconds)

      let currentTask = (gang->Gang.getMemberInformation(memberName)).task
      if currentTask === trainType {
        if gang->Gang.setMemberTask(memberName, oldTask) {
          ns->NS.print(`SUCCESS: stop training ${memberName}: ${trainType}`)

          true
        } else {
          ns->NS.print(`ERROR: failed to set task ${oldTask} to ${memberName}`)

          false
        }
      } else {
        ns->NS.print(
          `INFO: gang member ${memberName} is doing task ${currentTask}, so does not set the original task ${oldTask}`,
        )

        true
      }
    } else {
      ns->NS.print(`ERROR: failed to train ${memberName}: ${trainType}`)

      false
    }
  } else {
    ns->NS.print(`ERROR: missing ${trainType} or ${oldTask} in tasks`)

    false
  }
}
