local ccb = require("ccb")
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Retract",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=retract\n<color_light_green>Error: Insufficient confidence.\n<color_light_green>What is done cannot be undone.\n\n<color_light_green> @User > _</color>"),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_bbdf5436f867") } },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode0",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode0>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>Watch your step.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_4a09dc5c1966") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode1",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode1>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>You are free.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_95ccc09db2d6") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode2",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode2>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>Kick some ass.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_0fe6fdd500c8") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_passcode3",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend --pass=\"<ls_passcode3>\"\n<color_light_green>Command accepted.\n<color_light_green>Extending bridge.\n<color_light_green>Asshole.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_87ad9d7f3c89") },
        },
    },
}
