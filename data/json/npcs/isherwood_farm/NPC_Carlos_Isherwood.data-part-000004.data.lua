local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_TALK1",
    line = ccb.content.text("It is coming together.  I want to make our own tools, repair our items and even create some weapons and ammunition reloading."),
    replies = {
        { text = ccb.content.text("What do you need?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("I heard about Barry, can you tell me what captured him?"),
            next_topic = "TALK_CARLOS_BARRY",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
