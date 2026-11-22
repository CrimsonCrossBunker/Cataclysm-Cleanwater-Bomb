local ccb = require("ccb")
local actions = ccb.content.dialogue_actions



ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE",
    line = ccb.content.text("Sure, we could use some around here for repairs and whatnot.  What are the terms?"),
    replies = {
        {
            text = ccb.content.text("Well, how about 250 merch for 100 pounds of…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_01edabb98966") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE_CHEM",
    line = ccb.content.text("Chemicals?  I'm sure we could find some use for them, and we are in need of medical supplies.  What's the offer?"),
    replies = {
        {
            text = ccb.content.text("Well, how about 300 merch for 10 liters of…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_01edabb98966") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO",
    line = ccb.content.text("Listen, buddy.  We were putting away some of the last food you gave us and noticed it was… off.  Okay I'll cut the shit- It was people.  I don't know how you got it, or what you did, but we aren't taking any chances.  You are not welcome here anymore.  <color_red>I'll give you one minute</color> to fuck off and never come back."),
    on_enter = {
        { actions = { "end_conversation", actions.handler("w16b_a_dda_4548838cb2cf") } },
    },
    replies = {
        {
            text = ccb.content.text("But I-"),
            next_topic = "TALK_DONE",
        },
    },
}
