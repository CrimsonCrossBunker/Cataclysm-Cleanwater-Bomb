local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Must be tough having the world fall apart when you had you future to look forward to."),
            next_topic = "TALK_ISHERWOOD_LUKE3",
        },
        {
            text = ccb.content.text("Tell me about your dad."),
            next_topic = "TALK_LUKE_EDDIE_NoBarry",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Eddie_Isherwood" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } })) }),
        },
        {
            text = ccb.content.text("Tell me about your dad."),
            next_topic = "TALK_LUKE_EDDIE_YesBarry",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Eddie_Isherwood" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
