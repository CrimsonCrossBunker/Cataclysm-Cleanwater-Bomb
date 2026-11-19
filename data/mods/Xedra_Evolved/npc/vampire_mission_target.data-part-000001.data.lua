local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_CURE_REFUSE",
    line = ccb.content.text("How insulting.  You still think you hunters can do anything against me?  I'll prove you wrong."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE", native_actions = { "hostile" } } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_POWER_HUNGRY_ATTACK",
    line = ccb.content.text("Insufficiently servile.  No matter, there are more servants elsewhere."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE", native_actions = { "hostile" } } },
}
