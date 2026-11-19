local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_ACCEPTED",
    line = ccb.content.text("Excellent.  We look forward to your progress."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_hub_prototypes", "yes") },
        },
    },
}
