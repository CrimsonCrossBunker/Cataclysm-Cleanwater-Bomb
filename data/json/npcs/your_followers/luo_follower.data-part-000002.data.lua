local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_LUO_SOCIAL" },
    line = ccb.content.text("Sure.  Here we are, talking."),
    replies = {
        { text = ccb.content.text("What's your story, anyway?"), next_topic = "BGSS_Luo1" },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "BGSS_Luo_Expertise",
        },
        {
            text = ccb.content.text("I just wanted to chat, you know.  To relax."),
            next_topic = "TALK_FRIEND_LUO_CHAT",
            when = predicates.negate(predicates.has_effect("interlocutor", "asked_to_socialize")),
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}
