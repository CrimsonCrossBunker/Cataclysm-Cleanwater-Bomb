local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_BRIBE",
    line = ccb.content.text("How much are you thinking?"),
    replies = {
        {
            text = ccb.content.text("Does $5 sound good?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIVE",
        },
        {
            text = ccb.content.text("How about $20?"),
            trial = {
                kind = "persuade",
                difficulty = 10,
                modifiers = {
                    { score = "TRUST", scale = -3 },
                    { score = "VALUE", scale = -3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TWENTY_WIN" },
            failure = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TWENTY_FAIL" },
        },
        {
            text = ccb.content.text("I'll give you $50, my best offer."),
            trial = {
                kind = "persuade",
                difficulty = 20,
                modifiers = {
                    { score = "TRUST", scale = -3 },
                    { score = "VALUE", scale = -3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIFTY_WIN" },
            failure = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIFTY_FAIL" },
        },
    },
}
