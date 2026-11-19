local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_1_JOBS_2",
    line = ccb.content.text("Certainly.  I've just finished speaking with a certain individual, who has authorized you limited access to a selection of our internal stores.  We will provide you with pay for contracts in the form of tokens to be used as an exchange currency, which you can then trade for goods.  We are also amenable to bartering in exchange for supplies that are currently difficult for us to obtain from outside the facility."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_npc_intercom_trade", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_trade_unlocked" }, { "yes" }),
                actions.set_actor_value("speaker", "dialogue_intercom_completed_robofac_intercom_1", "yes"),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_1", { success = true }),
            },
            once = "unlocked_trade",
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind.  Let's get down to business."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES_FIRST",
        },
    },
}
