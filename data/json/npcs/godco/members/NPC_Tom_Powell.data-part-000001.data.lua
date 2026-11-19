local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet",
    line = ccb.content.text("Was it difficult to find us?  We haven't seen a single soul out there for so long, I'm starting to lose my hope.  So, tell me about yourself."),
    replies = {
        {
            text = ccb.content.text("I'm just a curious traveler.  What about you, how are you doing?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })),
            next_topic = "TALK_GODCO_Tom_Firstmeet2",
        },
        {
            text = ccb.content.text("I'm seeking asylum here.  What about you, how are you doing?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
            next_topic = "TALK_GODCO_Tom_Firstmeet2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
