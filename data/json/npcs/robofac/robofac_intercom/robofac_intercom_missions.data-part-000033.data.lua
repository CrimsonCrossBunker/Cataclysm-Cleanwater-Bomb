local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_DANGERS",
    line = ccb.content.text("There appear to be lifeforms, alien and otherwise.  We don't know anything about them."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_FIELD_TEAM",
    line = ccb.content.text("Yes, we've already contracted several others to perform surface reconnaissance.  It may be worth speaking with them to share information."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_SCAN_LOCATION",
    line = ccb.content.text("Yes, absolutely.  We think recordings from these exact coordinates will give us the most useful data on these volatile organics.  However, like other recordings, you don't need to be present for the full hour the recording runs - you can set up the station, leave, and come back later for the report."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_ACCEPTED",
    line = ccb.content.text("Excellent.  You'll meet the advanced team on the surface near your coordinates."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open and you deposit the report.  There is a brief silence, and then it opens with your payment.  \"You have our thanks and your payment.  It will take us some time for Research to digest this and the other field data, but perhaps we will have more related contracts for you later."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
