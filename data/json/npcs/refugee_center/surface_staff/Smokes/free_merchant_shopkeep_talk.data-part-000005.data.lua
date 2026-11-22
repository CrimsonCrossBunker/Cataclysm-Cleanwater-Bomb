local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited",
    line = ccb.content.text("I appreciate it a lot, getting them somewhere safe.  I hope that's what you did, anyway.  In any case, having the lobby clear is a big help.  Even with the uh, cardboard guy still around, he's a lot easier to handle alone."),
    on_enter = {
        { actions = { actions.update_map("shopkeep_lobby_cleanup1", "evac_center_13"), actions.update_map("shopkeep_lobby_cleanup2", "evac_center_18") } },
    },
    replies = {
        {
            text = ccb.content.text("I do believe we discussed a reward?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited_Reward",
        },
        {
            text = ccb.content.text("Just glad to help."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited_Reward",
    line = {
        joined = {
            ccb.content.text("And so we did.\"  Smokes reaches under their table, counts out some money, and slides it through a slot in the glass.  \"Here's five merch a head for the folks you found a new home for.  We won't forget it"),
            {
            when = predicates.handler("dlg_p_dda_1580c9fd076b"),
            yes = ccb.content.text(".\"\n\nLuo puts her hands on her hips.  \"You're getting *paid* for… ah, fuck it.  I should be pissed, but honestly I'm so glad to be out of this place, I can't even be mad.  That's really saying something, coming from me."),
            no = ccb.content.text("."),
        },
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_9d4a5a864597") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}
