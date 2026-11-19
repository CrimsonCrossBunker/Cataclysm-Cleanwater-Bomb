local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_DEFENSE_WANDERER_CALM",
    line = ccb.content.text("Oh, you're not one of the <zombies>.  I'm glad to see another survivor out here, such a relief."),
    replies = {
        {
            text = ccb.content.text("Alright, let's chat."),
            next_topic = "TALK_NPC_DEFENSE_WANDERER_INTRO",
        },
        { text = ccb.content.text("I'll be back later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_DEFENSE_WANDERER_INTRO",
    line = {
        choices = {
            ccb.content.text("What's up?"),
            ccb.content.text("What do you need?"),
            ccb.content.text("What can I do for you?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing out here in the sticks?"),
            next_topic = "TALK_NPC_DEFENSE_WANDERER_STORY",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_NPC_DEFENSE_WANDERER_INTRO",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Why don't you come with me, maybe we can hold out here?"),
            trial = { kind = "persuade", difficulty = -35, modifiers = { { score = "value", scale = 2 } } },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_DENY_FOLLOW",
                native_actions = { "deny_follow" },
                opinion = { trust = 0, fear = 0 },
            },
        },
        { text = ccb.content.text("I gotta go."), next_topic = "TALK_DONE" },
    },
}

-- Potential lore?  This could be a good mystery.
ccb.content.define_dialogue_topic {
    id = "TALK_NPC_DEFENSE_WANDERER_STORY",
    line = ccb.content.text("I can't remember, actually.  I have a vague sense of being in my house, asleep, before I woke up in the middle of a field.  I have this strange feeling that something's after me, keep seeing things out in the woods, so I had to keep moving."),
    replies = {
        {
            text = ccb.content.text("Seems like a hard life."),
            next_topic = "TALK_NPC_DEFENSE_WANDERER_INTRO",
        },
        {
            text = ccb.content.text("Where'd you get all your stuff at?"),
            next_topic = "TALK_NPC_DEFENSE_WANDERER_STUFF",
        },
        {
            text = ccb.content.text("I guess we're both in a similar predicament, then.  Why not team up with me?  We can hold out together and try to stay alive."),
            trial = { kind = "persuade", difficulty = -35, modifiers = { { score = "value", scale = 2 } } },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_DENY_FOLLOW",
                native_actions = { "deny_follow" },
                opinion = { trust = 0, fear = 0 },
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_DEFENSE_WANDERER_STUFF",
    line = ccb.content.text("I just found it near where I woke up at.  Who's it was and where it came from I have no idea, but I couldn't find anyone else around, and it seemed like it'd all been left there for someone to pick up."),
    replies = { { text = ccb.content.text("Makes sense."), next_topic = "TALK_NPC_DEFENSE_WANDERER_INTRO" } },
}
