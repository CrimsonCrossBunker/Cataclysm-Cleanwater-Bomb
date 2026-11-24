local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls",
    line = ccb.content.text("&You see a black computer screen with a flickering cursor and some text.  The cursor looks to be controlled by an old mouse that has been hard-wired to the side of terminal.  Only one option appears:\n\n<color_light_green> Labyrinth AB02123.3-4a</color>"),
    replies = {
        {
            text = ccb.content.text("[Select \"Labyrinth AB02123.3-4a - ERROR: NAY\"]"),
            next_topic = "COMP_LS_Entrance_Controls2_no",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "rubik_told_about_labyrinth" } })),
        },
        {
            text = ccb.content.text("[Select \"Labyrinth AB02123.3-4a\"]"),
            next_topic = "COMP_LS_Entrance_Controls2",
            when = predicates.handler("dlg_p_dda_f1f6c2ddcc67"),
        },
        {
            text = ccb.content.text("[Plug in your Exodii wrist computer and select \"Labyrinth AB02123.3-4a\"]"),
            next_topic = "COMP_LS_Entrance_Controls2",
            when = predicates.handler("dlg_p_dda_e783bd9bfc06"),
        },
        {
            text = ccb.content.text("[Select \"Labyrinth AB02123.3-4a - ERROR: 'wobble()' terminated.\"]"),
            next_topic = "COMP_LS_Entrance_Controls2_no_access",
            when = predicates.handler("dlg_p_dda_fb8cfccc393d"),
            actions = { actions.set_actor_value("speaker", "encountered_labyrinth_entry_error", "yes") },
        },
        {
            text = ccb.content.text("[Plug in your Exodii wrist computer and select \"Labyrinth AB02123.3-4a\"]"),
            next_topic = "COMP_LS_Entrance_Controls2_no_charges",
            when = predicates.handler("dlg_p_dda_7ea5db69a1b4"),
        },
        {
            text = ccb.content.text("[Select \"Labyrinth AB02123.3-4a - ERROR: CYCLE\"]"),
            next_topic = "COMP_LS_Entrance_Controls2_wait",
            when = predicates.handler("dlg_p_dda_a0f94d6967b0"),
        },
        {
            text = ccb.content.text("[Step away]"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_no",
    line = ccb.content.text("& User not permitted."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_wait",
    line = ccb.content.text("& Cycle in effect.  Wait five days from last jump."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_no_access",
    line = ccb.content.text("& ERROR: Doing 'wobble()' terminated unwarly.  DIAGNOSTIC: Labyrinth coordinate update required."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_no_charges",
    line = ccb.content.text("& ERROR: Doing 'wobble()' terminated unwarly.  DIAGNOSTIC: No valid coordinates in attached device."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2",
    line = ccb.content.text("& Truly?  Aye/Nay"),
    replies = {
        {
            text = ccb.content.text("[Select \"Aye\"]"),
            next_topic = "TALK_DONE",
            actions = { actions.finish_mission("MISSION_EXODII_LABYRINTHS_INTRO", { success = true }), actions.handler("w16b_a_dda_183f08bf4e45") },
        },
        {
            text = ccb.content.text("[Select \"Nay\"]"),
            next_topic = "COMP_LS_Entrance_Controls",
        },
    },
}
