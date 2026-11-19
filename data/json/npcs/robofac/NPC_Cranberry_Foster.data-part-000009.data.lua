local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_IF_I_OWE_YOU",
    line = ccb.content.text("Once we finish up this job, I'll vouch for you.  Pinkie promise."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_hub_merc_promised_u", "yes") } } },
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}
