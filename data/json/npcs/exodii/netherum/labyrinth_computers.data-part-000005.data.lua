local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door5",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --list\n<color_light_green>12 drwxr-xr-x 1 @User\n<color_light_green>File lost or deleted.\n<color_light_green>A new, stronger reality has supplanted the previous.  Thank you for using AltarOS.\n<color_light_green> @User > _"),
    replies = { { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" } },
}
