local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_askinterval",
    line = ccb.content.text("Well, not right now.  Try again after around <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text("Okay.  About other things…"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_2",
        },
    },
}
