local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MSU14_START", "MSU14_lOGIN_FAILED" },
    line = ccb.content.text("&<color_light_blue>Cyma Interface [version 0.85.1004]\n************************************************\n*  Copyright (c) Cyma Enterprise Systems 2023  *\n************************************************</color>\n\nLogin:\n\n"),
    replies = {
        { text = ccb.content.text("Attempt a login"), next_topic = "MSU14_lOGIN_FAILED" },
        {
            text = ccb.content.text("Login using the scribbled credentials"),
            next_topic = "MSU14_MAIN",
            when = predicates.has_item("speaker", "msu14_password"),
        },
        {
            text = ccb.content.text("Login with Hub 01 credentials"),
            next_topic = "MSU14_MAIN",
            when = predicates.has_mission("RD_1"),
        },
        { text = ccb.content.text("Shut down"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic { id = "MSU14_lOGIN_FAILED", line = ccb.content.text("&LOGIN FAILED\n\nLogin:\n\n") }

ccb.content.define_dialogue_topic {
    id = "MSU14_MAIN",
    line = ccb.content.text("&<color_red>WARNING: ADMINISTRATIVE LOCKDOWN IN EFFECT.  USAGE OF SYSTEM 14 HAS BEEN CURTAILED.</color>\n\n"),
    replies = {
        {
            text = ccb.content.text("Install the Hub software package."),
            next_topic = "MSU14_MISSION_COMPLETE",
            when = predicates.has_mission("RD_1"),
        },
        {
            text = ccb.content.text("Attempt to access System 14."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "computer_hacking_msu14_hack" } })),
            trial = { kind = "skill_check", difficulty = 5, skill = "computer" },
            success = { next_topic = "MSU14_UNIT_ACCESS" },
            failure = { next_topic = "MSU14_HACK_FAILURE" },
        },
        { text = ccb.content.text("Browse stored documents."), next_topic = "MSU14_PRE_DOCS" },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MSU14_MISSION_COMPLETE",
    line = ccb.content.text("&Processing 1 of 1 - Installing Sys3_rnp_4b12\n[====================] 100%\nThe operation completed successfully.\n\nRestart to apply changes.\nDo you want to restart now?  (Y/N)\n\n"),
    replies = {
        {
            text = ccb.content.text("Restart the computer and leave."),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("MSU14_LOCKED_START") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MSU14_PRE_DOCS",
    line = ccb.content.text("&Listing all saved files:\nA. P-144MS TALON UGV platform - Generative optimizations"),
    replies = {
        {
            text = ccb.content.text("View and print the Talon Schematics."),
            next_topic = "MSU14_DOCS_SUCCESS",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "computer_hacking_msu14_printed_docs" } })),
        },
        {
            text = ccb.content.text("View and print the Talon Schematics."),
            next_topic = "MSU14_DOCS_FAILURE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "computer_hacking_msu14_printed_docs" } }),
        },
        { text = ccb.content.text("Return."), next_topic = "MSU14_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MSU14_DOCS_SUCCESS",
    line = ccb.content.text("&Printing…"),
    replies = {
        {
            text = ccb.content.text("Return."),
            next_topic = "MSU14_MAIN",
            actions = { actions.handler("dlg_a_dda_33a0dce1e002"), actions.set_actor_value("speaker", "computer_hacking_msu14_printed_docs", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MSU14_DOCS_FAILURE",
    line = ccb.content.text("&ERROR: Schematic access denied - too many requests.\nPlease contact the system administrator."),
    replies = { { text = ccb.content.text("Return."), next_topic = "MSU14_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "MSU14_HACK_FAILURE",
    line = ccb.content.text("&<color_red>ERROR</color>"),
    on_enter = { { actions = { actions.set_actor_value("speaker", "computer_hacking_msu14_hack", "yes") } } },
    replies = { { text = ccb.content.text("Return"), next_topic = "MSU14_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "MSU14_UNIT_ACCESS",
    line = ccb.content.text("&Module Name - Notice of Deactivation\nThis unit has been disconnected and its predictive capabilities disabled.  Please press any key to export the results of the last logged experiment.\n\nNo further input will be processed.\nHave a nice day."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "computer_hacking_msu14_hack", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Press any key and shut down."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_e3b47843f525") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "MSU14_LOCKED_START" },
    line = ccb.content.text("&<color_light_blue>Cyma Interface [version 0.67.0459]\n************************************************\n*  Copyright (c) Cyma Enterprise Systems 2022  *\n************************************************</color>\n\nDATA TRANSMISSION COMPLETED.  NO FURTHER ACTIONS REQUIRED.\n\n"),
    replies = { { text = ccb.content.text("Shut down."), next_topic = "TALK_DONE" } },
}
