local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SPACEPORT_PORTMASTER_UP",
    line = ccb.content.text("Excellent, the current price for a trip up is 12500 USD.  Do you wish to book passage?"),
    replies = {
        {
            text = ccb.content.text("I'm ready, book me in the next ship."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_bc31ed04dad3") },
        },
        {
            text = ccb.content.text("I need to settle a few things first"),
            next_topic = "TALK_DONE",
        },
    },
}
