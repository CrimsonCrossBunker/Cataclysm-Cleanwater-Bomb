local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Resistance",
    line = ccb.content.text("The doctor has hired a mercenary team well known to us, all of which are former law enforcement.  Proceed with caution."),
}

-- The Hub in fact sactioned these experiments, but Melchior has determined that the experiments are endangering the Hub, and must be stopped.  The real justification is that they no longer expect the research to produce practical results, yet Dr. Harlow has refused to bend the knee and stop.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
    line = ccb.content.text("Dr. Harlow discovered some sort of alien robotics, and has been performing unsanctioned medical procedures in an attempt to implant them in living humans.  The experiments are unethical and a failure to boot, and thus must be stopped."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ACCEPTED",
    line = ccb.content.text("A makeshift laboratory and medical facility has been set up in a nearby dentist's office, where the alien structure was found.  We will transfer the coordinates.  We suggest you don't speak with Dr. Harlow, or anyone else.  Just execute your orders as quickly as possible."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open, filled with your payment.  \"The IRB thanks you for your service to ethics, and has asked us to remind you that the details of this assignment are to remain classified."),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
