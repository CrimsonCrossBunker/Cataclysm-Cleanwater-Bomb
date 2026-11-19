local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_TALK1",
    line = ccb.content.text("I run this dairy with my son, Luke.  It's been a tough job keeping the herd together, hasn't left a lot of time for other projects."),
    replies = {
        {
            text = ccb.content.text("I heard about Barry, such a tragedy.  Can you tell me more about what happened?"),
            next_topic = "TALK_ISHERWOOD_EDDIE2",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_barry_missing" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
