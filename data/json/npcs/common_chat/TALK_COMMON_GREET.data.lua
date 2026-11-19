local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DEMAND_LEAVE",
    line = ccb.content.gendered_line("Now get out of here, before I kill you.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Okay, I'm going."),
            next_topic = "TALK_DONE",
            native_actions = { "player_leaving" },
            opinion = { fear = -1 },
        },
    },
}
