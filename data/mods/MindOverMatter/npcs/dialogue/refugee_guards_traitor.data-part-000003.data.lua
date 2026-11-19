local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_direct_accusation" },
    line = ccb.content.text("What the hell are you talking about?"),
    replies = {
        {
            text = ccb.content.text("He was only a child, <npc_name>, and you killed him.  Do you remember the blood on his Superman shirt?"),
            next_topic = "TALK_EVAC_GUARD3_witch",
            opinion = { fear = 4 },
        },
    },
}
