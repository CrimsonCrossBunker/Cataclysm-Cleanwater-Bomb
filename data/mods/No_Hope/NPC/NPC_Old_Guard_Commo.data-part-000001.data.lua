local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_COMMO",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Marshal, I'm rather surprised to see you here."),
        no = {
            when = predicates.actor_state("speaker", "male"),
            yes = ccb.content.text("Sir you are not authorized to be here… you should leave."),
            no = ccb.content.text("Ma'am you are not authorized to be here… you should leave."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[MISSION] The captain sent me to get a frequency list from you."),
            next_topic = "TALK_OLD_GUARD_NEC_COMMO_FREQ",
            when = predicates.all({ predicates.wears("speaker", "badge_marshal"), predicates.has_mission("MISSION_OLD_GUARD_NEC_1"), predicates.negate(predicates.has_effect("speaker", "has_og_comm_freq")) }),
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_OLD_GUARD_NEC_COMMO_GOAL",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.has_effect("speaker", "has_og_comm_freq"), predicates.wears("speaker", "badge_marshal") }),
        },
        {
            text = ccb.content.text("About the mission…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.all({ predicates.assigned_missions(1, 1), predicates.wears("speaker", "badge_marshal") }),
        },
        {
            text = ccb.content.text("About one of those missions…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.all({ predicates.assigned_missions(2), predicates.wears("speaker", "badge_marshal") }),
        },
        { text = ccb.content.text("I should be going"), next_topic = "TALK_DONE" },
    },
}
