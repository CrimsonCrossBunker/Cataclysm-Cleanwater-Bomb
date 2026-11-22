local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_INTRO",
    line = {
        choices = {
            ccb.content.text("Normally I would tend to the wounded and do medical research, but with our relative safety and limited free time I mostly sell medical supplies these days.  I'm also the cook because nobody else here is good at cooking.  I would be surprised if one of them prepared an edible lung confit, let alone one that tastes good."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Show him your notes on aspirin improvement]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_ASPIRIN",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_extra_str_aspirin"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_aspirin" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_aspirin", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("[Show him your notes on overcharged energy drinks]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_RAGE_DRINK",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_blackout_rage_drink"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_rage_drink" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_rage_drink", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("[Show him your notes on precognition-inducing hallucinogens]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LSD",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_prophets_lsd"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_prophets_lsd" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_prophets_lsd", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("[Show him your notes on the elixir of life]"),
            next_topic = "TALK_HUNTER_DOCTOR_SHARE_LIFE_ELIXIR",
            when = predicates.all({ predicates.has_item("speaker", "alchemy_recipe_life_extension_potion"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shared_with_hunter_doctor_life_extension_potion" } })) }),
            actions = { actions.set_actor_value("speaker", "shared_with_hunter_doctor_life_extension_potion", "yes"), actions.handler("dlg_a_xedra_evolved_39dc5675bdd6") },
        },
        {
            text = ccb.content.text("I'll buy some supplies."),
            next_topic = "TALK_HUNTER_DOCTOR",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Could you give me some supplies?"),
            next_topic = "TALK_HUNTER_DOCTOR",
            when = predicates.handler("dlg_p_xedra_evolved_0a508fa5baff"),
            actions = { "start_trade", actions.handler("dlg_a_xedra_evolved_9f27406266ec") },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
