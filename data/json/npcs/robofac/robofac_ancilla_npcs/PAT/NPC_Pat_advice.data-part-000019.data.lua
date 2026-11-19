local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_pizzaiolo",
    line = ccb.content.text("Yeah………… how's'about you handle that one?"),
    replies = {
        {
            text = ccb.content.text("Right… fair enough."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_KILL_SLIMES",
    line = ccb.content.text("Take a mop.  Hah!"),
    replies = { { text = ccb.content.text("Right… thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_HUNT_ANTS",
    line = ccb.content.text("Ants?  Can't be that bad."),
    replies = { { text = ccb.content.text("Sure… thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
