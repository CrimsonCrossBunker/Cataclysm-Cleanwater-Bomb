local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_FRIENDLY",
    line = ccb.content.text("So what happens now?"),
    replies = {
        {
            text = ccb.content.text("Come with me.  We can help each other out."),
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "value", scale = 2 } } },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_DENY_FOLLOW",
                native_actions = { "deny_follow" },
                opinion = { trust = -1, fear = 1 },
            },
        },
        {
            text = ccb.content.text("We both go our separate ways.  Enjoy your freedom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_WARY",
    line = ccb.content.text("Why didn't you leave me frozen until things were better?"),
    replies = {
        {
            text = ccb.content.text("If I didn't thaw you out now, you'd have died in that pod."),
            trial = {
                kind = "persuade",
                difficulty = 5,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_THAWED_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_THAWED_LEAVES" },
        },
        {
            text = ccb.content.text("I'm being nice for now.  You'd better hope that it lasts."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_THAWED_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_THAWED_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        { text = ccb.content.text("Forget it.  Enjoy your freedom."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_FEARFUL",
    line = ccb.content.text("I'm sorry, what can I do to help you?"),
    replies = {
        {
            text = ccb.content.text("Follow me and do my bidding, then."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = {
                    { score = "FEAR", scale = 8 },
                    { score = "VALUE", scale = 2 },
                    { score = "TRUST", scale = 2 },
                    { score = "BRAVERY", scale = -2 },
                },
            },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_THAWED_BREAKDOWN",
                opinion = { trust = 4, value = -5, anger = 10 },
            },
        },
        {
            text = ccb.content.text("Get out of my sight."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
            opinion = { trust = -1, fear = -2, anger = -2 },
        },
        {
            text = ccb.content.text("No, *I'm* sorry, I didn't mean that.  Go do what you want."),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_DONE", opinion = { trust = 1, value = 1, anger = -1 } },
            failure = {
                next_topic = "TALK_THAWED_BREAKDOWN",
                opinion = { trust = 4, value = -5, anger = 10 },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_BREAKDOWN",
    line = ccb.content.text("How dare you threaten me!"),
    replies = {
        {
            text = ccb.content.text("Run while you still can!"),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = {
                    { score = "FEAR", scale = 8 },
                    { score = "VALUE", scale = 2 },
                    { score = "TRUST", scale = 2 },
                    { score = "BRAVERY", scale = -2 },
                },
            },
            success = { next_topic = "TALK_DONE", native_actions = { "flee" } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Not if I kill you first!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
        {
            text = ccb.content.text("I'm sorry!  I shouldn't have said that!"),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "TALK_DONE", opinion = { trust = 1, value = 1, anger = -1 } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_THAWED_LEAVES",
    line = ccb.content.text("Go freeze yourself.  Bye."),
    replies = { { text = ccb.content.text("Suit yourself."), next_topic = "TALK_DONE" } },
}
