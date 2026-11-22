local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_SERVICES",
    line = ccb.content.text("Welcome to the first American bank of munitions.  We convert your goods and services to the new gold standard."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_met_isolated_road_artisans", "yes"), actions.set_actor_value("speaker", "u_met_isolated_road_jay", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("About that contract…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("What's your deal?"),
            next_topic = "TALK_GUNSMITH_ABOUT",
        },
        {
            text = ccb.content.text("Munitions?"),
            next_topic = "TALK_GUNSMITH_SHOP_ABOUT",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_knows_about_conversion" } })),
        },
        {
            text = ccb.content.text("Hey.  Cody wanted to say that she's sorry.  She thought that you would want to see this."),
            next_topic = "TALK_GUNSMITH_KORD",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_kord", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_completed_quest" } }) }),
            actions = { actions.transfer_items("broken_kord") },
        },
        {
            text = ccb.content.text("I'm interested in helping with that thing for Cody."),
            next_topic = "TALK_GUNSMITH_Q1_DETAILS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_accepted_quest" } })) }),
            actions = { actions.offer_mission("MISSION_GUNSMITH_1"), actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_accepted_quest", "yes") },
        },
        {
            text = ccb.content.text("I'd like to exchange some rounds."),
            next_topic = "TALK_GUNSMITH_CONVERT_FROM_TYPE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_knows_about_conversion" } }),
        },
        {
            text = ccb.content.text("How are my rounds coming?"),
            next_topic = "TALK_GUNSMITH_BULLET_PICKUP",
            when = predicates.handler("dlg_p_dda_df5563c8a03b"),
        },
        {
            text = ccb.content.text("I'd like to convert some rounds."),
            next_topic = "TALK_GUNSMITH_CONVERT_TO_TYPE",
            when = predicates.handler("dlg_p_dda_09d75b71ed57"),
        },
        {
            text = ccb.content.text("Are you and Cody close?"),
            next_topic = "TALK_GUNSMITH_CODY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_cody" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_accepted_quest" } })) }),
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_GUNSMITH_LOCATION_ABOUT",
        },
        {
            text = ccb.content.text("About those contracts…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_artisans_made_up" } }), predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }) }),
        },
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_GUNSMITH_SERVICES",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("How's the 'printing' thing going?"),
            next_topic = "TALK_GUNSMITH_RESTOCK",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
