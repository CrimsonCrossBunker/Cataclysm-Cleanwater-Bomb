local ccb = require("ccb")

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
