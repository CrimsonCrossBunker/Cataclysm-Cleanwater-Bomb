local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_ASK",
    line = ccb.content.text("It was a modified Wraitheon chassis, with a custom AI.  We'd hoped that it would interact with the outside world for us, but you know how well that went.  That particular line of study is now on hiatus, given that the project lead… well, you know."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_told_about_prototype", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_told_prototype" }, { "yes" }),
            },
            once = "told_about_prototype",
        },
    },
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
