local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Marshal",
    line = ccb.content.text("I don't see how it's much of your business what our story is.  You can try asking my dad, Eddie, if you really want.  Just don't start acting like some little piece of tin in your pocket means you can come in like you own the place."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "isherwood_luke_marshal_questions", "known") },
        },
    },
    replies = {
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
