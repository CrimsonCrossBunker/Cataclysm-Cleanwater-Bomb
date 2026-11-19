local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_RED",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_red" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_dino_asked_about_kill_dinos" } }),
            yes = ccb.content.text("It's a good day to shoot some dinos."),
            no = ccb.content.text("You're back.  I knew you were a killer.  Are you ready to take this country back?"),
        },
        no = ccb.content.text("You there, wanderer.  You have the look of someone who hates dinosaurs.  Are you ready to take this country back?"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_red", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dinosaurs?  What are you talking about?"),
            next_topic = "TALK_RED_DINOSAURS",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_dino_asked_about_kill_dinos" } })),
            actions = { actions.set_actor_value("speaker", "dialogue_dino_asked_about_kill_dinos", "yes") },
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_OLD_GUARD_RED",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("How can I help?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_dino_asked_about_kill_dinos" } }),
        },
        {
            text = ccb.content.text("Mission update for you, Red."),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.all({ predicates.assigned_missions(1, 1) }),
        },
        { text = ccb.content.text("Anyway.  Take care, Red."), next_topic = "TALK_DONE" },
    },
}
