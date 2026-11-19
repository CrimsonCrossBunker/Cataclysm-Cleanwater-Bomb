local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open and you deposit the report.  There is a brief silence, and then it opens with your payment."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
