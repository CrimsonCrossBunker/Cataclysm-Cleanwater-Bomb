local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1",
    line = ccb.content.text("&You see a strangely mundane black computer screen, with a blinking green cursor awaiting input.\n\n<color_light_green> @User > _</color>"),
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Bridge_control_deadend_1_Extend_nopasscode",
    line = ccb.content.text("&<color_light_green> @User > bridge --update=extend\n<color_light_green>Error: No PASSCODE or CONFIDENCE.\n<color_light_green>If you have a PASSCODE, please enter using syntax --pass=\"your password\"\n<color_light_green>If you have not been granted a PASSCODE, contact your system obelisk for help.\n\n<color_light_green> @User > _"),
}
