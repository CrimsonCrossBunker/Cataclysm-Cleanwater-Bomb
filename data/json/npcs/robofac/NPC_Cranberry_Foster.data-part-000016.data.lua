local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_TRADE",
    line = {
        choices = {
            ccb.content.text("I appreciate it.  Here's the scrip; don't spend it all in one place."),
            ccb.content.text("Honestly, sometimes I feel like an ATM."),
            ccb.content.text("Thanks.  I never thought I'd get exhausted of carrying pure gold around, but here we are."),
            ccb.content.text("Exchanging my money for goods and services.  Just as the founding fathers intended."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_robofac_merc_1_gold_mission_complete", "yes"),
                actions.set_actor_value("speaker", "general_robofac_merc_1_helped_with_missions", "yes"),
            },
            once = "robofac_merc_1_first_gold_trade",
        },
    },
}
