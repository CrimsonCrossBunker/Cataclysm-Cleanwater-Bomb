local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TRUE_FOODPERSON_pizzaiolo",
    line = ccb.content.text("Umm, I'm not sure I'm following you…"),
    replies = {
        {
            text = ccb.content.text("You know what, <name_b>, I don't want to talk to you anymore.  <kill_npc> <name_b>!"),
            next_topic = "TALK_DONE",
            native_actions = { "insult_combat" },
        },
    },
}
