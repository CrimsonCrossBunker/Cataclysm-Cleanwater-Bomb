local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_SELL",
    line = ccb.content.text("Done."),
    on_enter = {
        { actions = { actions.handler("dlg_a_aftershock_exoplanet_281bd652ca97") } },
    },
    replies = {
        {
            text = ccb.content.text("A pleasure doing business."),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("ruin_data_mercurial_id") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_FAVOUR",
    line = ccb.content.text("For sure.  Just wait to see the things I'll cook up with these."),
    on_enter = {
        { actions = { actions.handler("dlg_a_aftershock_exoplanet_c1d7af39b63a") } },
    },
    replies = {
        {
            text = ccb.content.text("A pleasure doing business."),
            next_topic = "TALK_DONE",
            actions = { actions.transfer_items("ruin_data_mercurial_id") },
        },
    },
}
