local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Retract",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=retract\n<color_light_green>Error: Insufficient confidence.\n<color_light_green>What is done cannot be undone.\n\n<color_light_green> @User > _</color>"),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_bbdf5436f867") } },
    },
}
