local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Firstmeet",
    line = ccb.content.text("It's not often that we see new folks around the remnants of the New England Community Church.  So, got any tales to share from the outside world?"),
    replies = {
        {
            text = ccb.content.text("I'm just a curious traveler.  What's up with you?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })),
            next_topic = "TALK_GODCO_Russell_Story",
        },
        {
            text = ccb.content.text("I'm seeking asylum here.  What's up with you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
            next_topic = "TALK_GODCO_Russell_Story",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_GODCO_Russell_StoryB",
        },
    },
}
