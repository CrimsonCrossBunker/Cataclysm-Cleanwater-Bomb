local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GENDER",
    line = ccb.content.text("Yes."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_robofac_merc_1_asked_gender", "yes") },
            once = "robofac_merc_1_asked_gender",
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know what I was expecting."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}
