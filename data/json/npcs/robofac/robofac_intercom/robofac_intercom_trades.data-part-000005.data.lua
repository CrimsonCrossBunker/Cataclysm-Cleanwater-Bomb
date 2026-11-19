local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_NEGOTIATE",
    line = ccb.content.text("So we'd need a sweeter deal than just the money if we did this."),
    replies = {
        {
            text = ccb.content.text("I can pay you what I owe in cash and looted gear."),
            actions = {
                actions.set_actor_value("interlocutor", "npc_dialogue_intercom_u_pay_back_on_cash", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_pay_back_on_cash" }, { "yes" }),
            },
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_ON_CREDIT_ACCEPT",
        },
        {
            text = ccb.content.text("If you give me this deal you can have all the alien corpses, their stuff and their tower"),
            actions = {
                actions.set_actor_value("interlocutor", "npc_dialogue_intercom_u_pay_back_on_specimens", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_pay_back_on_specimens" }, { "yes" }),
            },
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_ON_CREDIT_ACCEPT",
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
