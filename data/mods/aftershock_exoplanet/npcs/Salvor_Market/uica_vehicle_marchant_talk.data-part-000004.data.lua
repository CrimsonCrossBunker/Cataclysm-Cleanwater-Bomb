local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BUY_VEHICLE_EARTH_2" },
    line = ccb.content.text("I'll cut you a deal.  Let's say 30,000 USD and it's all yours."),
    replies = {
        {
            text = ccb.content.text("I'll take it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_6616d9d8c75f") },
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}
