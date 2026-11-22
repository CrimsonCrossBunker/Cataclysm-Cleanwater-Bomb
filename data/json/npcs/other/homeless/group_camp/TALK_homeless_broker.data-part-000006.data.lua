local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_SMOKERACK",
    line = ccb.content.text("It's wonderful!  We've been preserving a lot more of what we manage to scavenge so we won't have to worry about our food going bad for a while.  We'd be willing to sell some of the excess, if you want."),
    replies = {
        {
            text = ccb.content.text("I think I'll buy 10 slices.  [$20]"),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_c65cf13e1f16") },
        },
        {
            text = ccb.content.text("You think 20 slices would be alright?  [$40]"),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_842cd0c2c186") },
        },
        {
            text = ccb.content.text("I'll take 50 slices of the stuff.  [$100]"),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_dda_6cb0766f5089") },
        },
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_NONE",
        },
    },
}
