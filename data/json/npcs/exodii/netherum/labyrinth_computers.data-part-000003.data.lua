local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Passcode_Door4",
    line = ccb.content.text("&<color_light_green> @User > doorstatus --update=unlock\n<color_light_green>Bad command or file name.\n<color_light_green>What is done cannot be undone.  Please see prior user warning.\n\n<color_light_green> @User > _"),
    replies = {
        {
            text = ccb.content.text("There must be some way to force the computer to do it."),
            next_topic = "COMP_LS_Passcode_Door4sudo",
        },
        { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" },
    },
}
