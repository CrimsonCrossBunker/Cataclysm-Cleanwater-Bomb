local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_PREPPER_SURVIVOR_STAY",
    line = ccb.content.text("Well, I guess you could borrow one of the spare beds, just don't hog it.  I kept a few in case someone else joined me, but no one I knew came here."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO",
            actions = { actions.handler("dlg_a_dda_cda1365f4ecb") },
        },
    },
}
