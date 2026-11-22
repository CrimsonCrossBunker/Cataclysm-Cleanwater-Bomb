local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_JOIN_RESCUE",
    line = ccb.content.text("&She listens intently as you explain.  \"All right.  I'll be ready at the tower when you need me.\""),
    replies = {
        {
            text = ccb.content.text("Great.  I'll see you there."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_4a6eb839c8e7") },
        },
    },
}
