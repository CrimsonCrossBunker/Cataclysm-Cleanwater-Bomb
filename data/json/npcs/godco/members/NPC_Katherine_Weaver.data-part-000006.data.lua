local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Angry_Pressed",
    line = ccb.content.text("&Katherine scowls with anger at you.  \"This is the exact <freaking> reason I don't want to talk to you, now go away!\""),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_f8bf9c2ba3b5") } },
    },
    replies = {
        {
            text = ccb.content.text("Fuck's sake <name_b>, I'm leaving!"),
            next_topic = "TALK_DONE",
        },
    },
}
