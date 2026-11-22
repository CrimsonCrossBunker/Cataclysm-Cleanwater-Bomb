local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_7",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }),
        yes = ccb.content.gendered_line("My savior!  My patron of the arts!  You're always welcome here, friend.", { "speaker" }),
        no = ccb.content.text("Man, just imagine what I could do with a new guitar."),
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_e06c65c8caa1") } },
    },
    replies = {
        {
            text = ccb.content.text("Let's talk about getting you that guitar."),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } })),
        },
        {
            text = ccb.content.text("I've been thinking about that deal you mentioned."),
            next_topic = "TALK_REFUGEE_Draco_10_approve",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_barter_NC_REFUGEE_Draco_offered_weed_deal" } }),
        },
        {
            text = ccb.content.text("Anything you buying or selling, by chance?"),
            next_topic = "TALK_REFUGEE_Draco_8",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_barter_NC_REFUGEE_Draco_offered_weed_deal" } })),
            actions = { actions.set_actor_value("speaker", "general_barter_NC_REFUGEE_Draco_offered_weed_deal", "yes") },
        },
        {
            text = ccb.content.text("Do you know any tunes good to dance to?"),
            next_topic = "TALK_REFUGEE_Draco_Dance",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_NC_REFUGEE_Draco_has_guitar" } }),
        },
        {
            text = ccb.content.text("See you around, Draco."),
            next_topic = "TALK_DONE",
        },
    },
}
