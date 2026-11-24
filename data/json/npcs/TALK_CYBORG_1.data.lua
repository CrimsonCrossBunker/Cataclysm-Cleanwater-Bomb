local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_cyborg_cyborg_has_talked" } }),
        yes = ccb.content.text("Hey again.  *kzzz*"),
        no = ccb.content.gendered_line("I… I'm free.  *Zzzt* I'm actually free!  *bzzz* Look, you're the first person I've seen in a long time.", { "interlocutor" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_cyborg_cyborg_has_talked", "yes") },
        },
    },
    replies = {
        {
            switch = true,
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_cyborg_cyborg_has_talked" } }),
            text = ccb.content.text("Hey.  Let's chat for a second."),
            next_topic = "TALK_STRANGER_NEUTRAL",
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("That's because I saved you.  Listen, I could use your help…"),
            trial = { kind = "persuade", difficulty = 0 },
            success = { next_topic = "TALK_CYBORG_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_CYBORG_WARY", opinion = { anger = 1, fear = 1 } },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("Big fucking deal.  Do what I say or I'll shove that chip back where it belongs."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_CYBORG_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_CYBORG_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        {
            switch = true,
            default = true,
            text = ccb.content.text("Sorry, I'm nobody.  Enjoy your freedom, I guess."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_FRIENDLY",
    line = ccb.content.text("*buzz* Great!  So what happens now?"),
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
    id = "TALK_CYBORG_WARY",
    line = ccb.content.text("…Wait.  *BEEP* Why do I believe you?  *ZZZT* You could be just as bad as them!"),
    replies = {
        {
            text = ccb.content.text("I wouldn't have pulled your chip out if I didn't want you to think for yourself."),
            trial = {
                kind = "persuade",
                difficulty = 5,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_CYBORG_FRIENDLY", opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_CYBORG_LEAVES" },
        },
        {
            text = ccb.content.text("For all you know, I did.  I'm being nice for now.  You'd better hope that it lasts."),
            trial = {
                kind = "intimidate",
                difficulty = 20,
                modifiers = { { score = "AGGRESSION", scale = -2 }, { score = "BRAVERY", scale = -2 } },
            },
            success = {
                next_topic = "TALK_CYBORG_FEARFUL",
                opinion = { trust = -4, fear = 3, value = -1, anger = 4 },
            },
            failure = {
                next_topic = "TALK_CYBORG_BREAKDOWN",
                opinion = { trust = -4, value = -5, anger = 10 },
            },
        },
        { text = ccb.content.text("Forget it.  Enjoy your freedom."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_FEARFUL",
    line = ccb.content.text("Okay, okay, *BUZZ* I'm sorry!  Don't hurt me again!  Anything but the chip!"),
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
                next_topic = "TALK_CYBORG_BREAKDOWN",
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
                next_topic = "TALK_CYBORG_BREAKDOWN",
                opinion = { trust = 4, value = -5, anger = 10 },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYBORG_BREAKDOWN",
    line = ccb.content.text("…kill… *ZTZTZT* …you!"),
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
    id = "TALK_CYBORG_LEAVES",
    line = ccb.content.text("Yeah, *beeeeep* I don't think so.  <end_talking_bye>"),
    replies = { { text = ccb.content.text("Suit yourself."), next_topic = "TALK_DONE" } },
}
