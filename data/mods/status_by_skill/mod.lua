local ccb = require("ccb")

return ccb.ModDefinition {
    id = "status_by_skill",
    name = ccb.content.text("Status by Skill"),
    authors = { "续命狂蛤-江借时" },
    maintainers = { "续命狂蛤-江借时" },
    description = ccb.content.text("状态随着技能等级的提高提高"),
    category = "rebalance",
}
