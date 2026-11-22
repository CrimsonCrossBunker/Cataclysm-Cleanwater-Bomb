local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_witch" },
    line = ccb.content.text("I didn't tell you my na-\"  <npc_name>'s face goes white.  \"What the fuck!  You some kind of freak?"),
    replies = {
        {
            text = ccb.content.text("It's over.  Give up."),
            next_topic = "TALK_EVAC_GUARD3_DEAD",
            actions = { actions.handler("dlg_a_mindovermatter_6abd6bb21f81") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_WEAPON_TELEPORT_DISAMED",
    line = ccb.content.text("*stares at you with eyes wide as their weapon vanishes into thin air.  Their mouth works silently but no sounds come out."),
    replies = {
        {
            text = ccb.content.text("Get out of here or you'll be next."),
            trial = { kind = "intimidate", difficulty = 8, modifiers = { { score = "FEAR", scale = 6 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_SUCCESS_TELEPORT_LEAVE", actions = { "flee", actions.handler("dlg_a_mindovermatter_c86cc50b1935") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_WEAPON_TELEKIN_DISAMED",
    line = ccb.content.text("*starts as the weapon is ripped out of their hands and falls to the floor.  \"Holy shit!  What the fuck?!\""),
    replies = {
        {
            text = ccb.content.text("Leave or I'll do the same to you."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "FEAR", scale = 5 } } },
            success = { next_topic = "TALK_EVAC_GUARD3_SUCCESS_TELEKIN_LEAVE", actions = { "flee", actions.handler("dlg_a_mindovermatter_22abd5d5205c") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}
