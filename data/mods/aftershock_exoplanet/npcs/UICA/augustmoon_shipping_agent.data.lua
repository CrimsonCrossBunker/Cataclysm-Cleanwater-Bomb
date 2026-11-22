local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_LANDING",
    line = ccb.content.text("Excellent, the current price for a passage down is 1000 USD.  If there's any cargo you wish to transfer planetside please place it in the nearby container.  Additionally, I'm obliged to inform you that a return passage is considerably more expensive, having a current price of 12500 USD.  Do you wish to book passage?"),
    replies = {
        {
            text = ccb.content.text("I'm ready, book me in the next ship down."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_824101549704") },
        },
        {
            text = ccb.content.text("I need to settle a few things first"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_KIT",
    line = ccb.content.text("The kit is available as a one-time purchase for 3660 USD.  It includes a basic set of thermal clothing for survival, a backpack, basic cooking implements and supplies, a self-defense weapon and some basic medical supplies.  It is designed to help you survive the first few days planetside, but it is not a complete solution for long-term survival."),
    replies = {
        {
            text = ccb.content.text("I'll take it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_b5399379ef32") },
        },
        {
            text = ccb.content.text("Let me think about it."),
            next_topic = "TALK_AUGUSTMOON_SHIPPING_CHIEF",
        },
    },
}
