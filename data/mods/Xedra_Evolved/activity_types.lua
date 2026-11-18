local ccb = require("ccb")
local content = ccb.content

content.add(content.ActivityType {
    id = "ACT_CHANGELING_DREAMDROSS_TO_DREAMSPARKS",
    verb = ccb.content.text("extracting dreams"),
    based_on = "time",
    activity_level = 1,
})

content.add(content.ActivityType {
    id = "act_xedra_time_freeze",
    verb = ccb.content.text("frozen in time"),
    based_on = "time",
    activity_level = 1,
    interruptable = false,
    interruptable_with_keyboard = false,
    can_resume = false,
})
