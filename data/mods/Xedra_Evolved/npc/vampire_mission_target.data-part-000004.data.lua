local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MISSION_TARGET_CURE_CONVINCED",
    line = ccb.content.text("Okay, I'll take the cure."),
    replies = {
        {
            text = ccb.content.text("[Give them the cure]"),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("blood_treatment"), actions.set_actor_value("speaker", "completed_hunter_cure_target", "yes"), actions.handler("dlg_a_xedra_evolved_59715f55401e") },
        },
    },
}
