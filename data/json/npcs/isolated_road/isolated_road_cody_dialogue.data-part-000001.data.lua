local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_RESTOCK",
    line = ccb.content.text("With how the things are goin'? <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text("I'll leave you to your work then.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_ABOUT",
    line = {
        choices = {
            ccb.content.text("I'm Cody, was an engineer before everything went to hell.  I guess I still am, but I don't have to consult anymore, so I consider that a plus at least."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What's with all the weapons and armor?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT",
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_BLACKSMITH_LOCATION_ABOUT",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}
