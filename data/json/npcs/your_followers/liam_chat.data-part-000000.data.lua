local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_Liam_SOCIAL" },
    line = ccb.content.text("Any time, what's on your mind?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on a job we're doing."),
            next_topic = "TALK_Liam_Opinions",
        },
        {
            text = ccb.content.text("[Raise your hand for a high-five.]"),
            next_topic = "TALK_Liam_HighFive",
        },
        {
            text = ccb.content.text("Can I ask you a bit about yourself?"),
            next_topic = "BGSS_Liam1",
        },
        {
            text = ccb.content.text("You picked up a lot of useful skills over the years, hey."),
            next_topic = "BGSS_Liam_Expertise",
        },
        {
            text = ccb.content.text("I just wanted to chat, you know.  To relax."),
            next_topic = "TALK_FRIEND_Liam_CHAT",
            when = predicates.negate(predicates.has_effect("interlocutor", "asked_to_socialize")),
        },
        {
            text = ccb.content.text("The way you said something earlier made me realize… you have a crush on Jenny Forcette, don't you."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.all({ predicates.any_equal({ "crush_suspected", { scope = "speaker", key = "u_liam_jenny_feelings" } }), predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })) }),
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}
