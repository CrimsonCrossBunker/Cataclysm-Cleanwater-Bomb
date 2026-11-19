local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_FREE_MERCHANT_DELIVERY_MERCENARY_END",
    line = ccb.content.text("Thank you.  Was there anything else you needed?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS",
    line = ccb.content.text("That question has… a complicated answer."),
    replies = {
        {
            text = ccb.content.text("I'd like to hear it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_1",
        },
        { text = ccb.content.text("Later, then."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}
