local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_BACKGROUND_END",
    line = ccb.content.text("*smiles at you, genuine and warm.  \"It feels nice to tell it.  You're welcome.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_robofac_merc_1_heard_backstory", "yes") },
            once = "robofac_merc_1_background_shared",
        },
    },
    replies = {
        { text = ccb.content.text("[Spend a while in silence.]"), next_topic = "TALK_DONE" },
        { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" },
    },
}
