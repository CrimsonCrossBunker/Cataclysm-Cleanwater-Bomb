local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_C_LOVE",
    line = ccb.content.text("I love you."),
    replies = {
        { text = ccb.content.text("Oh, uh, thanks.  I guess."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("No thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A1",
    line = ccb.content.text("Please don't hurt us, we're just trying to get to safety."),
    on_enter = {
        { actions = { actions.set_first_topic("TALK_CARAVAN_REFUGEE_A2") } },
    },
    replies = {
        {
            text = ccb.content.text("What's your situation here?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A1_Job",
        },
        {
            text = ccb.content.text("I don't mean any harm.  I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_CARAVAN_REFUGEES_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("I don't have time for zombie bait like you."),
            next_topic = "TALK_DONE",
        },
    },
}
