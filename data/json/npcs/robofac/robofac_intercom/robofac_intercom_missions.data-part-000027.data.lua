local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER_ADVICE_HEW",
    line = ccb.content.text("The station is a self-contained meteorology unit like the one you've previously used.  The case is black, and will be marked as a \"Hazardous Environment\" unit.  It will have been kept behind a locked door, but this is likely non-functional without power.  The station is situated in a lake and was actively researching the effects of… weather… on the sediment, so there may be other access points."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3_ACCEPTED",
    line = ccb.content.text("Excellent.  See you soon."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3_COMPLETE",
    line = ccb.content.text("Fantastic.\"  The intercom's tray slides open, you deposit the datasheet, and it quickly closes.  There is a brief silence, and then it opens again, this time with your payment.  \"You have our thanks and your payment, once again.  If you are interested in an open-ended contract as a research, we are prepared to offer you one."),
    replies = {
        {
            text = ccb.content.text("Thank you.  I'll consider it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
