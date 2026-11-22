local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_MAIN",
    replies = {
        {
            text = ccb.content.text("Gain [<trait_name:perk_money_maker_merc>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_money_maker_merc")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_money_maker_merc>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_money_maker_merc>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_money_maker_merc" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have completed a wave" }), actions.handler("dlg_a_defense_mode_58e96e9a7004") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_slice&dice>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_slice&dice")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_slice&dice>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_slice&dice>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_slice&dice" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_defense_mode_8bc0dece8a8d") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_bash&mash>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_bash&mash")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_bash&mash>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_bash&mash>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_bash&mash" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_defense_mode_8bc0dece8a8d") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_knifey>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_knifey")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_knifey>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_knifey>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_knifey" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_defense_mode_8bc0dece8a8d") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_melee_master>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_melee_master")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_melee_master>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_melee_master>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_melee_master" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Slice & Dice, Bash & Mash, and Knifey" }), actions.handler("dlg_a_defense_mode_b07e0566006f") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_gymrat_king>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_gymrat_king")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_gymrat_king>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_gymrat_king>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_gymrat_king" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires athletics 5 and Gym Rat" }), actions.handler("dlg_a_defense_mode_a5d3000f212f") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_extra_life>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_extra_life")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_extra_life>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_extra_life>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_extra_life" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_defense_mode_8bc0dece8a8d") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_mysterious_stranger>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_mysterious_stranger")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_mysterious_stranger>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_mysterious_stranger>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_mysterious_stranger" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_defense_mode_8bc0dece8a8d") },
        },
    },
}
