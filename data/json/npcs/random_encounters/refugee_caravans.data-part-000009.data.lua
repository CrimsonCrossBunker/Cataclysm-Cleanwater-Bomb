local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Join_No",
    line = ccb.content.text("Actually, I think I'm on the right track here, but you might have some luck finding a little something something back at the Free Merchant base.  They seemed pretty desperate."),
    replies = {
        {
            text = ccb.content.text("Of course.  How do I get there?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        { text = ccb.content.text("Yes.  I'll be on my way then."), next_topic = "TALK_DONE" },
    },
}
