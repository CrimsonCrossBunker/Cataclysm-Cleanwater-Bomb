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
