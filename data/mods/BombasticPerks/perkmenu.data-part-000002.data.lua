local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_SELECT",
    line = ccb.content.text("<context_val:trait_name>: \"<context_val:trait_description>\"\n<context_val:trait_requirement_description>.\n<context_val:trait_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_bombasticperks_9920859920ca"),
            actions = { actions.handler("dlg_a_bombasticperks_45c4c5af4786") },
            failure_topic = "TALK_PERK_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "trait_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_SELECT_PLAYSTYLE",
    line = ccb.content.text("<context_val:trait_name>: \"<context_val:trait_description>\"\nCosts 1 playstyle perk point and 1 perk point, <context_val:trait_requirement_description>.\n<context_val:trait_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_bombasticperks_393c21bf0c6a"),
            actions = { actions.handler("dlg_a_bombasticperks_f347a8013f73") },
            failure_topic = "TALK_PERK_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_PLAYSTYLE",
            actions = { actions.set_string({ scope = "conversation", key = "trait_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}
