local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CONFIG_NOTIFICATIONS",
    line = ccb.content.text("Should the perk menu pop up on level up?"),
    replies = {
        {
            text = ccb.content.text("Yes"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_dc438cae4f88"),
            actions = { actions.handler("dlg_a_bombasticperks_30f11bba1ce4") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("No"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_71b0d0c3afec"),
            actions = { actions.handler("dlg_a_bombasticperks_cc661ab8e241") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_CONFIG",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CONFIG_EXP_TO_LEVEL",
    line = ccb.content.text("Set exp required per level.  Does not affect levels already gained, or current level."),
    replies = {
        {
            text = ccb.content.text("None (0 exp)"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_a2a3bf53d567"),
            actions = { actions.handler("dlg_a_bombasticperks_aa346ea52a2f") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("Normal (300 XP)"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_e2eab097807c"),
            actions = { actions.handler("dlg_a_bombasticperks_a9b50a016adf") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("Large (1000 XP)"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_8f9f1603b746"),
            actions = { actions.handler("dlg_a_bombasticperks_15e2b9fe1396") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("Very Large (10000 XP)"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_428170bfb771"),
            actions = { actions.handler("dlg_a_bombasticperks_fedd5c37b47b") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_CONFIG",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_REQUIREMENTS",
    line = ccb.content.text("Should there be requirements to get perks?"),
    replies = {
        {
            text = ccb.content.text("Prerequisites"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_017b4e708f52"),
            actions = { actions.handler("dlg_a_bombasticperks_3d3d57b35045") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("No Prerequisites"),
            next_topic = "TALK_PERK_MENU_CONFIG",
            when = predicates.handler("dlg_p_bombasticperks_377d73361911"),
            actions = { actions.handler("dlg_a_bombasticperks_6da35b6693a4") },
            failure_topic = "TALK_PERK_MENU_CONFIG",
            failure_explanation = ccb.content.text("Current Setting"),
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_CONFIG",
        },
    },
}
