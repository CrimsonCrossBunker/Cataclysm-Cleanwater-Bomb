local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_2",
    line = ccb.content.text("What do you need?"),
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("Corrie and I have finished that solar cart."),
            when = predicates.any_equal({ "in-progress", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
            next_topic = "TALK_GODCO_Helena_Negotiate",
        },
        {
            text = ccb.content.text("Olwen's finished the radio transmitter she was working on."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })), predicates.negate(predicates.has_mission("MISSION_GODCO_HELENA_VISIT_MERCHANTS")), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_godco_has_radio" } }) }),
            next_topic = "TALK_GODCO_Helena_Contact_FreeMerch",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
