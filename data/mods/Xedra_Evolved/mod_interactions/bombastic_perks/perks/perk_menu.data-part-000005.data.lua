local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_ALCHEMY3",
    line = ccb.content.text("<trait_name:perk_ALCHEMY3>: \"<trait_description:perk_ALCHEMY3>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_6f9d73792bd9"),
            actions = { actions.replace_mutation("speaker", "perk_ALCHEMY3"), actions.handler("dlg_a_xedra_evolved_0379580f0feb") },
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
    replies = {
        {
            text = ccb.content.text("Gain [<trait_name:perk_ALCHEMY3_COLD_IRON>]"),
            next_topic = "TALK_PERK_MENU_ALCHEMY3_COLD_IRON",
            when = predicates.handler("dlg_p_xedra_evolved_c4ea3cbe252c"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_ALCHEMY3_COLD_IRON",
    line = ccb.content.text("<trait_name:perk_ALCHEMY3_COLD_IRON>: \"<trait_description:perk_ALCHEMY3_COLD_IRON>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_6f9d73792bd9"),
            actions = { actions.replace_mutation("speaker", "perk_ALCHEMY3_COLD_IRON"), actions.handler("dlg_a_xedra_evolved_0379580f0feb") },
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
