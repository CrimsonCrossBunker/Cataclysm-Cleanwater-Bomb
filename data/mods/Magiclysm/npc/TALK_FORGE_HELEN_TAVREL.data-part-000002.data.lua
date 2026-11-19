local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_REAGENT_ASK_BUYING",
    line = ccb.content.text("I am always on the lookout for weapons and ammo.  I am also happy to relieve you of your treasures."),
    replies = { { text = ccb.content.text("I'll keep an eye out."), next_topic = "TALK_FORGE_LORD_REAGENT" } },
}
