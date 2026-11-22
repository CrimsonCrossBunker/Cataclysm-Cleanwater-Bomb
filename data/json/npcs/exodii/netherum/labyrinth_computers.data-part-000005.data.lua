local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door4sudo",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=unlock --force\n<color_light_green>Error: Insufficient confidence.\n<color_light_green>Aborted: No forceable process.\n @User > sudo doorstatus --update=unlock\n<color_light_green>Oh, is that how it will be?  Very well.\n<color_light_green>Blood tax requested.\nA drawer on the side of the terminal slides open, revealing a small, thin needle.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("[ Prick yourself on the needle ]"),
            next_topic = "COMP_LS_Passcode_Door4blood",
            actions = { actions.handler("dlg_a_dda_3844a4c79ca6") },
        },
        {
            text = ccb.content.text("Log off."),
            next_topic = "TALK_DONE",
        },
    },
}
