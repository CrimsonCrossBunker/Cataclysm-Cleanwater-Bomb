local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_ASK_INTERVAL",
    line = ccb.content.text("My minions are busy putting the final touches on a few exciting projects, check back on <restock_time_point> and see what's new."),
    replies = { { text = ccb.content.text("May your hammers be accurate."), next_topic = "TALK_FORGE_LORD" } },
}
