local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "BEM_HIREABLE_1" },
    line = ccb.content.text("I'm just looking for my next job.  So if you can't help with that, I rather we be on our own separate ways."),
    replies = {
        {
            text = ccb.content.text("Well then, what does it cost to hire you."),
            next_topic = "BEM_HIREABLE_2",
        },
        {
            text = ccb.content.text("Ha I prefer the cheerful sort anyways."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Well whatever."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HIREABLE_2",
    line = ccb.content.gendered_line("The mercenary's demeanor changes completely when they realize you aren't here to waste time.  \"Alright, tell you what.  Get me twelve coins and that's giving my skills away, just anything to be done with that voice on a box.\"", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I might be back."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[12 HGC] You have a deal."),
            next_topic = "BEM_HIREABLE_3",
            when = predicates.has_inventory("speaker", "RobofacCoin", 12),
            actions = { actions.handler("dlg_a_dda_b6b8885af26b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_HIREABLE_3",
    line = ccb.content.text("I guess you're the boss."),
    replies = {
        {
            text = ccb.content.text("Glad to have you aboard."),
            success = {
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
                next_topic = "TALK_DONE",
            },
        },
    },
}
