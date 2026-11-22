local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PAY_BACK_RIOT_GEAR",
    line = ccb.content.gendered_line("Good thing you came back with the money.  Your mission work out?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I appreciate the credit.  I've got your payment now."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_8948663cd33d"), actions.finish_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR", { success = true }) },
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PAY_BACK_RIOT_GEAR_SPECIMENS",
    line = ccb.content.text("[thanks bro this will be very interesting where's the tower?]"),
    replies = {
        {
            text = ccb.content.text("[tell them where scout tower is]"),
            actions = { actions.finish_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR", { success = true }) },
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
