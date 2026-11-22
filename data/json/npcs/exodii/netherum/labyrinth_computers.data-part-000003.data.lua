local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = "COMP_LS2_MAP_2",
    line = ccb.content.text("&<color_light_green> @User > map get --update\n<color_light_green> Error: Insufficient confidence.  Blood tax requested.\n\n</color>A drawer on the side of the terminal slides open, revealing a a bloodstained stone with the outline of a human hand."),
    replies = {
        {
            text = ccb.content.text("[Place your hand on the stone]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_f8667a737fe5") },
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door",
    line = ccb.content.text("&You see a strangely mundane black computer screen, with a blinking green cursor awaiting input.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("Unlock connected doors"),
            next_topic = "COMP_LS_Passcode_Door2",
            when = predicates.handler("dlg_p_dda_71a22aa1f1e5"),
            actions = { actions.handler("dlg_a_dda_a367c3d39b59") },
        },
        {
            text = ccb.content.text("Lock connected doors"),
            next_topic = "COMP_LS_Passcode_Door3",
            when = predicates.handler("dlg_p_dda_030d3a2a8399"),
            actions = { actions.handler("dlg_a_dda_d9abc3d845b3") },
        },
        {
            text = ccb.content.text("Unlock connected doors"),
            next_topic = "COMP_LS_Passcode_Door4",
            when = predicates.handler("dlg_p_dda_2cae08f533b6"),
        },
        {
            text = ccb.content.text("Now all the doors are *gone*, what the hell."),
            next_topic = "COMP_LS_Passcode_Door5",
            when = predicates.handler("dlg_p_dda_01a3d73e8fc7"),
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door2",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=unlock\n<color_light_green>Command accepted.\n<color_light_green>Nearby doors unlocked.\n<color_light_green>Thank you for using AltarOS.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_c965521e93b8") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door3",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=lock\n<color_light_green>Command accepted.\n<color_light_green>Nearby doors locked.\n<color_light_green>Warning: What is done cannot be undone.  This does not represent a return to how things were.  You can never go back.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_602258923b5d") },
        },
    },
}
