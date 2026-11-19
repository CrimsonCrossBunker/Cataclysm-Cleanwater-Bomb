local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ASK_INTERVAL",
    line = {
        choices = {
            ccb.content.text("We have no other disposable equipment right now.  You'll have to come back after <restock_time_point>."),
            ccb.content.text("No. Come back after <restock_time_point>."),
        },
    },
    replies = { { text = ccb.content.text("Right…"), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
