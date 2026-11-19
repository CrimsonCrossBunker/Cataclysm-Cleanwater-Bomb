local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE_BONE_SEER",
    line = ccb.content.text("I have taught you much.  A little more won't hurt."),
    replies = {
        {
            text = ccb.content.text("And I listen, as you have taught me to."),
            next_topic = "TALK_TRAIN",
            actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_PERSUADE_BONE_SEER",
    line = ccb.content.text("I haven't taught so many people before, I'll try my best."),
    replies = {
        {
            text = ccb.content.text("I know you'll do well."),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_TRAIN_SEMINAR" },
            failure = {
                next_topic = "TALK_DENY_PERSONAL",
                actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}
