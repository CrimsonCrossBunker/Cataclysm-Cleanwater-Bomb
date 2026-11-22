local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR",
    line = {
        choices = {
            {
            when = predicates.has_trait("speaker", "VAMPIRE"),
            yes = {
                choices = {
                    {
                    when = predicates.handler("w16b_p_xedra_evolved_952e7812cbf7"),
                    yes = ccb.content.text("I can give you some cure for your vampirism.  You helped us, so I'll help you in turn."),
                    no = ccb.content.text("Looking to buy the cure to your vampirism?  I would give it for free if I could, but its ingredients are so hard to find now.  Phyliss can help you if you're desperate."),
                },
                },
            },
            no = {
                choices = {
                    ccb.content.text("Welcome."),
                    ccb.content.text("Hello."),
                    ccb.content.text("Hi."),
                    ccb.content.text("You need something?"),
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I have the ginseng you asked for."),
            next_topic = "TALK_HUNTER_DOCTOR_FIND_GINSENG_COMPLETE",
            when = predicates.all({ predicates.has_item("speaker", "xe_elder_ginseng"), predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_life_extension_potion" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "gave_hunter_doctor_elder_ginseng" } })) }),
            actions = { actions.transfer_items("xe_elder_ginseng"), actions.set_actor_value("speaker", "gave_hunter_doctor_elder_ginseng", "yes"), actions.finish_mission("MISSION_VAMPIRE_HUNTER_DOCTOR_FIND_GINSENG", { success = true }), actions.handler("w16b_a_xedra_evolved_11c9ecaecc8c") },
        },
        {
            text = ccb.content.text("[Show him your notes on aspirin improvement]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_ASPIRIN",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_extra_str_aspirin"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_aspirin" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_aspirin", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("[Show him your notes on overcharged energy drinks]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_RAGE_DRINK",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_blackout_rage_drink"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_rage_drink" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_rage_drink", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("[Show him your notes on precognition-inducing hallucinogens]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LSD",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_prophets_lsd"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_prophets_lsd" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_prophets_lsd", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("[Show him your notes on the elixir of life]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LIFE_ELIXIR",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_life_extension_potion"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_life_extension_potion" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_life_extension_potion", "yes"), actions.handler("w16b_a_xedra_evolved_3a02bfb200e3") },
        },
        {
            text = ccb.content.text("I'll buy some cure.  [10$]"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_e23f13094bcb"),
            actions = { actions.handler("w16b_a_xedra_evolved_d9fb058089f3") },
        },
        {
            text = ccb.content.text("I'd like to have some cure."),
            next_topic = "TALK_HUNTER_DOCTOR_GIVE_CURE",
            when = predicates.handler("w16b_p_xedra_evolved_bd4c4a567679"),
            actions = { actions.handler("w16b_a_xedra_evolved_067e0015be5d") },
        },
        {
            text = ccb.content.text("[30m] Could you patch me up?"),
            next_topic = "TALK_HUNTER_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_952e7812cbf7"),
            actions = { "give_aid", actions.handler("w16b_a_xedra_evolved_79c405cd4be8") },
        },
        {
            text = ccb.content.text("[1h] Could you to patch my friends up?"),
            next_topic = "TALK_HUNTER_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_xedra_evolved_dfec4b4de226"),
            actions = { "give_all_aid", actions.handler("w16b_a_xedra_evolved_fa5f4419f53a") },
        },
        {
            text = ccb.content.text("What's your role here?"),
            next_topic = "TALK_HUNTER_DOCTOR_INTRO",
        },
        {
            text = ccb.content.text("Do you have something to trade?"),
            next_topic = "TALK_HUNTER_DOCTOR",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Do you have some free things for me?"),
            next_topic = "TALK_HUNTER_DOCTOR",
            when = predicates.handler("w16b_p_xedra_evolved_952e7812cbf7"),
            actions = { "start_trade", actions.handler("w16b_a_xedra_evolved_cf46f00fa379") },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
