local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_ADVICE",
    line = ccb.content.text("There is.  If the robot is operational, it's very likely to be hostile and extremely dangerous.  I don't recommend fighting it directly.  Dr. Prado left the building with a handful of EMP grenades.  If you can locate those grenades, use them to disable the prototype instead."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where is the test site?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_1") },
        },
        {
            text = ccb.content.text("Extremely dangerous?  What kind of danger should I expect?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ADVICE_2",
        },
        {
            text = ccb.content.text("I'll pass on getting killed today, thanks."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_ADVICE_2",
    line = ccb.content.text("It's built with experimental combat programming and some heavy-duty armor.  Despite the armor, it's pretty nimble, so unless you've got a vehicle don't expect to outrun it.  We decided to hold off on adding long-range weapons until we finished the initial field testing, so if you can keep your distance, you should be safe."),
    replies = {
        {
            text = ccb.content.text("I can handle it.  Where is the test site?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_1") },
        },
        { text = ccb.content.text("I think I'll pass."), next_topic = "TALK_DONE" },
    },
}
