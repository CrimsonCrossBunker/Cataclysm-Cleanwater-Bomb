local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE",
    line = ccb.content.text("Why should I teach you?"),
    replies = {
        {
            text = ccb.content.text("Come on, we're friends."),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_TRAIN" },
            failure = {
                next_topic = "TALK_DENY_PERSONAL",
                actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_nevermind>  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_PERSUADE",
    line = ccb.content.text("Why should I host a training seminar?"),
    replies = {
        {
            text = ccb.content.text("Come on, we're friends."),
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
        { text = ccb.content.text("<end_talking_nevermind>  <lets_go>"), next_topic = "TALK_DONE" },
    },
}
