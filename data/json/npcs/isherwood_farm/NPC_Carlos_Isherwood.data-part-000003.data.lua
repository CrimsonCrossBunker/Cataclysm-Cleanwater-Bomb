local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CARLOS_MarshalSaveBarry",
    line = ccb.content.text("*struggles to think of a reply for a moment, then drops his hand from his gun.  \"We've got that under control, but you're not wrong.  An extra pair of hands wouldn't hurt, just now.  Just keep that damn badge out of my sight.\""),
    on_enter = { { actions = { actions.set_first_topic("TALK_ISHERWOOD_CARLOS_ConvincedMarshal") } } },
    replies = {
        {
            text = ccb.content.text("Fine.  Thanks.  Tell me more about what happened to Barry."),
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
