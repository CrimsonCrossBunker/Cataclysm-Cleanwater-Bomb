local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "spaceport_portmaster",
    class = "NC_AUGUSTMOON_shipping_chief",
    attitude = 0,
    mission = "SHOPKEEP",
    suffix = ccb.content.text("Portmaster"),
    chat = "TALK_SPACEPORT_PORTMASTER",
    faction = "UICA",
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPACEPORT_PORTMASTER",
    line = ccb.content.text("Do you want to book passage back to the station?"),
    replies = {
        {
            text = ccb.content.text("That's why I'm here."),
            next_topic = "TALK_SPACEPORT_PORTMASTER_UP",
        },
        { text = ccb.content.text("Not right now."), next_topic = "TALK_DONE" },
    },
}

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
