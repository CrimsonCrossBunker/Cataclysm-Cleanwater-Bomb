local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_BRIBE_SUCCESS",
    line = ccb.content.text("Alright, alright.  You can buy stuff here, but don't expect help when you get in over your head."),
    on_enter = {
        { actions = { actions.handler("dlg_a_aftershock_exoplanet_e04f10f958b7") } },
    },
    replies = {
        {
            text = ccb.content.text("Wont be a problem."),
            next_topic = "TALK_SALVOR_RIPPER_MAIN",
        },
    },
}
