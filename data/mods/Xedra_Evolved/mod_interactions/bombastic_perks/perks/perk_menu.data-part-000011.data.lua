local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_LOW_INT_MANA",
    line = ccb.content.text("<trait_name:perk_LOW_INT_MANA>: \"<trait_description:perk_LOW_INT_MANA>\""),
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_6f9d73792bd9"),
            actions = { actions.replace_mutation("speaker", "perk_LOW_INT_MANA"), actions.handler("dlg_a_xedra_evolved_0379580f0feb") },
            failure_topic = "TALK_PERK_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_MAIN",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Gain [<trait_name:perk_GRACKEN_FRIENDSHIP>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_GRACKEN_FRIENDSHIP")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_GRACKEN_FRIENDSHIP>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_GRACKEN_FRIENDSHIP>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_GRACKEN_FRIENDSHIP" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No requirements" }), actions.handler("dlg_a_xedra_evolved_19b7a9d02af2") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_PLAYSTYLE",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Gain [<trait_name:perk_xe_vampire_killer>]"),
            next_topic = "TALK_PERK_MENU_SELECT_PLAYSTYLE",
            when = predicates.negate(predicates.has_trait("speaker", "perk_xe_vampire_killer")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_xe_vampire_killer>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_xe_vampire_killer>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_xe_vampire_killer" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No requirements" }), actions.handler("dlg_a_xedra_evolved_19b7a9d02af2") },
        },
    },
}
