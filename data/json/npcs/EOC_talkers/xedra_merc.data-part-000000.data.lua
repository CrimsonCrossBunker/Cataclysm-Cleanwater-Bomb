local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_XEDRA_MERC_MAIN",
    line = ccb.content.text("As you approach you feel compelled to touch the creature encased in glass.  The corpse inside is screaming, it needs your help."),
    replies = {
        {
            text = ccb.content.text("Say: \"Is someone there?\""),
            next_topic = "TALK_XEDRA_MERC_SCREEM",
        },
        { text = ccb.content.text("Touch it."), next_topic = "TALK_XEDRA_MERC_HAUNTING" },
        { text = ccb.content.text("Back away."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_XEDRA_MERC_SCREEM",
    line = ccb.content.text("An almost human voice erupts in your mind:\n\"FREE ME!\""),
    replies = {
        { text = ccb.content.text("Touch it."), next_topic = "TALK_XEDRA_MERC_HAUNTING" },
        { text = ccb.content.text("Back away."), next_topic = "TALK_DONE" },
    },
}
