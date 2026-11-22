local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_STAY",
    line = ccb.content.text("Well, I don't see anything wrong with it.  We should have a spare bed in that tent you could sleep on.  Just don't cause any trouble."),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_b1ea186390a0") },
        },
    },
}
