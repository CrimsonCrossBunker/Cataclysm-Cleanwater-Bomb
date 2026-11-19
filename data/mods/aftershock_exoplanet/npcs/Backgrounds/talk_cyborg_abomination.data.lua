local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_ABOMINATION_FRIENDLY",
    line = ccb.content.text("*crackle* So why would you do this?"),
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
    id = "TALK_CYBORG_ABOMINATION_WARY",
    line = ccb.content.text("…This is just another torture isn't it!"),
    replies = {
        {
            text = ccb.content.text("I went to a lot of trouble to provide you with a body."),
            trial = {
                kind = "persuade",
                difficulty = 5,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_CYBORG_ABOMINATION_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_CYBORG_ABOMINATION_LEAVES" },
        },
        {
            text = ccb.content.text("For all you know, I did.  I'm being nice for now.  You'd better hope that it lasts."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_CYBORG_ABOMINATION_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_CYBORG_ABOMINATION_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        { text = ccb.content.text("Forget it.  Enjoy your freedom."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_ABOMINATION_FEARFUL",
    line = ccb.content.text("Okay, okay, *sizzle* I'm sorry!  Don't hurt me again!  Anything to stay away from those fiends!"),
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
                next_topic = "TALK_CYBORG_ABOMINATION_BREAKDOWN",
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
                next_topic = "TALK_CYBORG_ABOMINATION_BREAKDOWN",
                opinion = { trust = 4, value = -5, anger = 10 },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_ABOMINATION_BREAKDOWN",
    line = ccb.content.text("…You're one of those mocking monsters!  I'm going to tear you apart!"),
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
    id = "TALK_CYBORG_ABOMINATION_LEAVES",
    line = ccb.content.text("I don't know what's happening but I'm going back home."),
    replies = { { text = ccb.content.text("Suit yourself."), next_topic = "TALK_DONE" } },
}
