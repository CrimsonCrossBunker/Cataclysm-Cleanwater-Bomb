local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Contact_FreeMerch",
    line = ccb.content.text("Yes, I was just informed of that.  I also heard that she found a large group of people living out in an old evacuation center, who consider themselves merchants.  That would be a good place to resume our spread of the Truth, perhaps we could find others who were faithful before <the_cataclysm>."),
    replies = {
        {
            text = ccb.content.text("I presume you want me to pay a visit?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
            next_topic = "TALK_GODCO_Helena_Accept_Contact_FreeMerch",
        },
        {
            text = ccb.content.text("Oh, I've met them before!"),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } }) }),
            next_topic = "TALK_GODCO_Helena_Accept_Contact_FreeMerch",
        },
        { text = ccb.content.text("Let's change the subject."), next_topic = "TALK_GODCO_Helena_2" },
        { text = ccb.content.text("Good luck with that."), next_topic = "TALK_DONE" },
    },
}
