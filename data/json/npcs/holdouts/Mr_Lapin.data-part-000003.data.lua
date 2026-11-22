local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_ISHERWOOD",
    line = ccb.content.text("There is a family of nearby farmers that I trade with.  I'd appreciate it if you could go check on them."),
    replies = {
        {
            text = ccb.content.text("Seems like a deal to me."),
            next_topic = "TALK_WARRENER_ISHERWOOD_MISSION_ACCEPTED",
            actions = { actions.offer_mission("MISSION_Warrener_ISHERWOOD") },
        },
        {
            text = ccb.content.text("That seems rather dangerous, I think I'll pass."),
            next_topic = "TALK_WARRENER",
        },
    },
}
