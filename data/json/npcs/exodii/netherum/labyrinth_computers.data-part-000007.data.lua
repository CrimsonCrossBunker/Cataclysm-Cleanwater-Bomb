local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "COMP_LS_Bridge_control_deadend_1", "COMP_LS_Bridge_control_deadend_1_Retract", "COMP_LS_Bridge_control_deadend_1_Extend_nopasscode" },
    replies = {
        {
            text = ccb.content.text("Enter the Thief's Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode0",
            when = predicates.handler("dlg_p_dda_d7ff7f872ba8"),
            actions = { actions.handler("dlg_a_dda_b9e11b3b4756") },
        },
        {
            text = ccb.content.text("Enter the Circle of Wings Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode1",
            when = predicates.handler("dlg_p_dda_5297030f1842"),
            actions = { actions.handler("dlg_a_dda_6015d8edf9b2") },
        },
        {
            text = ccb.content.text("Enter the Hard Nails Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode2",
            when = predicates.handler("dlg_p_dda_b1655aa596fc"),
            actions = { actions.handler("dlg_a_dda_511bfe0a2f04") },
        },
        {
            text = ccb.content.text("Enter the Laughing Man Passcode to extend the bridge."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_passcode3",
            when = predicates.handler("dlg_p_dda_509946616d1f"),
            actions = { actions.handler("dlg_a_dda_fae4b4269f34") },
        },
        {
            text = ccb.content.text("Try to extend the bridge to the treasure room."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Extend_nopasscode",
            when = predicates.handler("dlg_p_dda_c0a8dade4e0d"),
        },
        {
            text = ccb.content.text("Retract the bridge"),
            next_topic = "COMP_LS_Bridge_control_deadend_1_Retract",
            when = predicates.handler("dlg_p_dda_7feef9b48ebf"),
        },
        {
            text = ccb.content.text("[Computers] Try to find a way to force it."),
            next_topic = "COMP_LS_Bridge_control_deadend_1_force",
            when = predicates.handler("dlg_p_dda_7bda4c3336de"),
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}
