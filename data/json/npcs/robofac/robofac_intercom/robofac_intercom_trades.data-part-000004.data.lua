local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR",
    line = ccb.content.text("There is an infinite supply of the stuff but I guess from us you can get it clean and undamaged.  That'll be $400."),
    replies = {
        {
            text = ccb.content.text("[8 HGC] Deal!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.has_inventory("speaker", "RobofacCoin", 8),
            actions = { actions.handler("dlg_a_dda_1a1507c0fc87"), actions.set_actor_value("interlocutor", "npc_dialogue_exodii_npc_bought_riot_gear", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_bought_riot_gear" }, { "yes" }) },
        },
        {
            text = ccb.content.text("I'm a little tight on funds right now.  Can we work out a buy now pay later deal?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_NEGOTIATE",
            when = predicates.negate(predicates.has_inventory("speaker", "RobofacCoin", 8)),
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
