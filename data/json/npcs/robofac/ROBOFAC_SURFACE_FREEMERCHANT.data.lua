local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_FREE_MERCHANT_INTERVAL",
    line = ccb.content.text("Around <restock_time_point>, if the caravan doesn't run into trouble."),
    replies = { { text = ccb.content.text("Thanks for the info, bye."), next_topic = "TALK_DONE" } },
}
