local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
    line = ccb.content.text("<context_val:chronomancer_menu_choice_name>: \"<context_val:chronomancer_menu_choice_description>\"\nSpell Difficulty:<context_val:chronomancer_menu_difficulty>\n<context_val:chronomancer_menu_requirement_description>.\n<context_val:chronomancer_menu_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Learn Power."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5ec7ca106bcd"),
            actions = { actions.handler("dlg_a_xedra_evolved_4158d561cb43") },
            failure_topic = "TALK_CHRONOMANCER_SPELL_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
    line = ccb.content.text("<context_val:chronomancer_menu_choice_name>: \"<context_val:chronomancer_menu_choice_description>\"\nSpell Level:<context_val:chronomancer_spell_level>\n<context_val:chronomancer_menu_requirement_description>.\n<context_val:chronomancer_menu_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Level Power."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5ec7ca106bcd"),
            actions = { actions.handler("dlg_a_xedra_evolved_81702efd677c") },
            failure_topic = "TALK_CHRONOMANCER_SPELL_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_TRAIT_MENU_SELECT",
    line = ccb.content.text("<context_val:chronomancer_menu_choice_name>: \"<context_val:chronomancer_menu_choice_description>\"\n<context_val:chronomancer_menu_requirement_description>.\n<context_val:chronomancer_menu_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Resolve Problem."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5ec7ca106bcd"),
            actions = { actions.handler("dlg_a_xedra_evolved_ecbdaa951f27") },
            failure_topic = "TALK_CHRONOMANCER_TRAIT_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_MENU_SETTINGS",
    line = ccb.content.text("Chronomancy Settings:"),
    replies = {
        {
            text = ccb.content.text("Disable Insight Gain Messages."),
            next_topic = "TALK_CHRONOMANCER_MENU_SETTINGS",
            when = predicates.handler("dlg_p_xedra_evolved_7b4bc1011653"),
            actions = { actions.handler("dlg_a_xedra_evolved_025fe1f04f4d") },
        },
        {
            text = ccb.content.text("Enable Insight Gain Messages."),
            next_topic = "TALK_CHRONOMANCER_MENU_SETTINGS",
            when = predicates.handler("dlg_p_xedra_evolved_164a52567b2b"),
            actions = { actions.handler("dlg_a_xedra_evolved_1ee970e6ee34") },
        },
        {
            text = ccb.content.text("Main Menu."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}
