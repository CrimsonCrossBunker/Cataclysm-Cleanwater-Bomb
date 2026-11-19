local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Firstmeet",
    line = ccb.content.text("You look somewhat interesting.  So, what's your story?"),
    replies = {
        {
            text = ccb.content.text("I'm just a curious traveler."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            next_topic = "TALK_GODCO_Olwen_Traveler",
        },
        {
            text = ccb.content.text("I'm seeking asylum here."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            next_topic = "TALK_GODCO_Olwen_Joinee",
        },
        {
            text = ccb.content.text("I'm just a curious traveler."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            next_topic = "TALK_GODCO_Olwen_Mutant_Traveler",
        },
        {
            text = ccb.content.text("I'd rather not say.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
