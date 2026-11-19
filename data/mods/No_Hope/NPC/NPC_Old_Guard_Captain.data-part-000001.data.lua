local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_CPT",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Marshal, I hope you're here to assist us."),
        no = {
            when = predicates.actor_state("speaker", "male"),
            yes = ccb.content.text("Sir, I don't know how the hell you got down here but if you have any sense you'll get out while you can."),
            no = ccb.content.text("Ma'am, I don't know how the hell you got down here but if you have any sense you'll get out while you can."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing down here?"),
            next_topic = "TALK_OLD_GUARD_NEC_CPT_GOAL",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Can you tell me about this facility?"),
            next_topic = "TALK_OLD_GUARD_NEC_CPT_VAULT",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("What do you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.wears("speaker", "badge_marshal"),
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
        { text = ccb.content.text("I've got to go…"), next_topic = "TALK_DONE" },
    },
}
