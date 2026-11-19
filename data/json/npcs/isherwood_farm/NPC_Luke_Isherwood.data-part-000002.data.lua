local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_BOOKS1",
    line = ccb.content.text("*gestures to where they sit on a shelf.  \"I've been trying to look at them, but I can't focus too much right now.\"  He smiles sadly.  \"Hope to get to them soon.\""),
    replies = {
        {
            text = ccb.content.text("Because of Barry?"),
            next_topic = "TALK_ISHERWOOD_LUKE_BOOKS_BARRY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }),
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
