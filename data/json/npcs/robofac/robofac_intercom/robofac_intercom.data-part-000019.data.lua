local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_2",
    line = ccb.content.text("&The intercom is silent."),
}

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_3", line = ccb.content.text("Ask Gavin.") }

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_END",
    line = ccb.content.text("&The tray slides shut.  \"Thank you.\"  The intercom turns off without another word."),
    replies = { { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" } },
}
