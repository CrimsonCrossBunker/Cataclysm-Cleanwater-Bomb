local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_TWO_OF_US",
    line = ccb.content.text("I guess so.\"  They beam sheepishly.  \"Uh, call me Cranberry.  Cran is fine too.  It's nice to meet someone else from here.  I guess having some company for once wouldn't be awful."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_robofac_merc_1_robofac_merc_1_stay", "yes"),
            },
            once = "robofac_merc_1_stay",
        },
    },
    replies = {
        { text = ccb.content.text("Alright."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" },
        {
            text = ccb.content.text("I guess I could stay for a while."),
            next_topic = "TALK_ROBOFAC_MERC_1_STAY_AWHILE",
        },
        {
            text = ccb.content.text("Actually, I have some places to be right now.  Good to meet you."),
            next_topic = "TALK_DONE",
        },
    },
}
