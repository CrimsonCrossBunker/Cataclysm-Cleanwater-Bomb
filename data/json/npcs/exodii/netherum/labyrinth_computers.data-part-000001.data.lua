local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_LS2_MAP",
    line = ccb.content.text("&<color_light_green> AltarOS map-node ONLINE.\n<color_light_green> Connection to AltarOS remote FAILED.\n<color_light_green> @User > _"),
    replies = {
        { text = ccb.content.text("Download map data."), next_topic = "COMP_LS2_MAP_2" },
        { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" },
    },
}
