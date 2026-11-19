local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE_Liam",
    line = ccb.content.text("I mean, I'm not sure what I can teach you about, but okay."),
    replies = {
        {
            text = ccb.content.text("Don't sell yourself short, Liam.  I just wanted to know about…"),
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
    id = "TALK_TRAIN_SEMINAR_PERSUADE_Liam",
    line = ccb.content.text("A… seminar?  About what, how not to burn yourself on the frier at Foodplace?"),
    replies = {
        {
            text = ccb.content.text("Y'know, you have more useful skills than you think."),
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
