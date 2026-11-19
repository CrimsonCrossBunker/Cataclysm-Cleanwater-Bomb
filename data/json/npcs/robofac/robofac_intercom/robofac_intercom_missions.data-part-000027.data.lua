local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_MWS",
    line = ccb.content.text("The station is a self-contained meteorology unit like the one you've previously used.  The case is black, and will be marked as a \"Hazardous Environment\" unit.  It will have been kept behind a locked door, but this is likely non-functional without power.  The station is situated in a lake and was actively researching the effects of… weather… on the sediment, so there may be other access points."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_Dangers",
    line = ccb.content.text("The station is inactive and drone footage suggests it has been barricaded.  We do not know what or who is inside."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_ACCEPTED",
    line = ccb.content.text("Excellent.  Transferring the coordinates now."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_COMPLETE",
    line = ccb.content.text("Fantastic.  Please hand over the unit.\"  The intercom's tray slides open, you deposit the device, and it quickly closes.  There is a brief silence, and then it opens again, this time with your payment.  \"You have our thanks and your payment, once again.  Please let us know if you are interested in additional field work."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
