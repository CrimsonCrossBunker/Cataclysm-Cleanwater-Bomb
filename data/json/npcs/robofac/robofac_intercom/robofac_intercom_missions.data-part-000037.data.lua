local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS_ADVICE_ANDURIL",
    line = ccb.content.text("They are, or were, a defense contractor.  They are headquartered elsewhere, but maintained software engineering offices here, and we believe this one was testing the MVAS system."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS_ACCEPTED",
    line = ccb.content.text("Use this ID card to access the facility.\"  The slot opens, revealing a small ID badge.  \"Report back with the system.  Naturally, you may keep anything else you find."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open and you deposit the headset.  There is a brief silence, and then it opens with your payment.  \"You have our thanks and your payment.  Return in approximately five days and R&D may have a prototype visual augmentation system ready for testing."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
