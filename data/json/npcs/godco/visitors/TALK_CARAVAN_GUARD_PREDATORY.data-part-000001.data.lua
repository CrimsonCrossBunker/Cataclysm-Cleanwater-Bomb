local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_PICKUP",
    line = ccb.content.gendered_line("Really, I haven't heard anything about it.  What's it you need?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("The boss wants your accounting papers, I need them."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_ACCRECORDS",
        },
        {
            text = ccb.content.text("Oh nothing, I must have the wrong person."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_ACCRECORDS",
    line = ccb.content.text("They're not ready yet, you'll have to come back later."),
    replies = {
        {
            text = ccb.content.text("I'll just take them as is, thanks.  Everything can be finalized later."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_NOW",
        },
        {
            text = ccb.content.text("We both know that's a lie.  Hand them over, or else."),
            trial = {
                kind = "intimidate",
                difficulty = 10,
                modifiers = {
                    { score = "TRUST", scale = 3 },
                    { score = "VALUE", scale = 3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = {
                next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS",
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Could I get them for a price?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_BRIBE",
        },
        {
            text = ccb.content.text("When will they be ready?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TIME",
        },
        { text = ccb.content.text("Okay, see ya."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_NOW",
    line = ccb.content.gendered_line("I told you already, I'm not finished with them, come back later.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("We both know that's a lie.  Hand them over, or else."),
            trial = {
                kind = "intimidate",
                difficulty = 10,
                modifiers = {
                    { score = "TRUST", scale = 3 },
                    { score = "VALUE", scale = 3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = {
                next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS",
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Could I get them for a price?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_BRIBE",
        },
        {
            text = ccb.content.text("When will they be ready?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TIME",
        },
        { text = ccb.content.text("Okay, see ya."), next_topic = "TALK_DONE" },
    },
}
