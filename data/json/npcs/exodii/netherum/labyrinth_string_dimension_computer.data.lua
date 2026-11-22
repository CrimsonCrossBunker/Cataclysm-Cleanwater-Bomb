local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_SD_Entrance_Controls2",
    line = ccb.content.text("&The screen starts to auto-populate with text, and then two options appear at the bottom:\n\n<color_light_green> @Awīlu > īnu -nērubu -KÁ -@Awīlu\n<color_light_green> nērub ašram ellam\n\n<color_yellow> [annu]\n\n<color_yellow> [adīni lā]"),
    replies = {
        {
            text = ccb.content.text("[Select \"annu\"]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_aa509652e8e5") },
        },
        {
            text = ccb.content.text("[Select \"adīni lā\"]"),
            next_topic = "COMP_LS_SD_Entrance_Controls",
        },
    },
}
