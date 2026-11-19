local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_TEAMUP",
    line = ccb.content.text("It's crazy out there, it's going to be a tough journey but I'm with you!"),
    replies = {
        {
            text = ccb.content.text("Let's go, we have a world to save!"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
            opinion = { trust = 20, value = 20 },
        },
    },
}
