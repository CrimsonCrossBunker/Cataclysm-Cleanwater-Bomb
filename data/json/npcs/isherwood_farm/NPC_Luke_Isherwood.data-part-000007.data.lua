local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_BARRY",
    line = ccb.content.text("*goes a bit pale.  \"I shouldn't have said that.  Not my place to talk to a stranger about it.\""),
    replies = {
        {
            text = ccb.content.text("I already know Barry got captured.  I just wanted to know a bit more about it.  Maybe I can help."),
            next_topic = "TALK_LUKE_BARRY2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }),
        },
        {
            text = ccb.content.text("I might be able to help, though."),
            next_topic = "TALK_LUKE_BARRYhelp",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } })),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
