local ccb = require("ccb")
local content = ccb.content

content.add(content.ActivityType {
    id = "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS",
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 2,
    interruptable = false,
})

content.add(content.ActivityType {
    id = "ACT_PSI_TELEPORTER_ATTUNING",
    verb = ccb.content.text("attuning to area"),
    based_on = "time",
    activity_level = 2,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_CRYSTAL_AWAKENING_MEDITATION",
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 2,
    interruptable = false,
    interruptable_with_keyboard = false,
})
