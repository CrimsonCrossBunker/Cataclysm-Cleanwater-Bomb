local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR", "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR_INFO" },
    line = ccb.content.text("Given the context of your assignment, we are willing to sell you a set of our protective gear - a gas mask and an environmental suit - at a considerable discount.  We will part with it for two exchange coins.\"  The intercom waits expectantly.  \"Actually, hold on, we might not have one in your size…"),
    replies = {
        {
            text = ccb.content.text("[2 HGC] Deal!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.has_inventory("speaker", "RobofacCoin", 2),
            actions = { actions.handler("dlg_a_dda_079275754668"), actions.set_actor_value("interlocutor", "dialogue_intercom_npc_bought_protective_gear", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_bought_protective_gear" }, { "yes" }) },
        },
        {
            text = ccb.content.text("What will it do for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR_INFO",
        },
        {
            text = ccb.content.text("I have to give it a thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
