local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Recruit",
    line = ccb.content.text("Sure, I'll come.  I hate staying here, and you've gone out of your way to help me.  I appreciate that, <name_g>."),
    replies = {
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") },
        },
    },
}
