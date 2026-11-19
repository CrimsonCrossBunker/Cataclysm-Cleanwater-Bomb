local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SOLDIER_QMASTER",
    line = {
        choices = {
            ccb.content.text("Welcome to camp Arabella, What will it be?"),
            ccb.content.text("I'm the camp quartermaster.  Come and see me if you have anything valuable to trade."),
            ccb.content.text("If you're looking to trade you've come to the right place."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_SOLDIER_QMASTER",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
