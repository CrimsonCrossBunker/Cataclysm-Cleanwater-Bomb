local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Recorder",
    line = ccb.content.text("Once the storm starts, it should be enough to walk outside while carrying the NRE, as the recording requires no particular actions on your part.  Research insist on the fact that you must personally carry the NRE on your person to take accurate measurements, so leaving it outside while you take shelter won't work.  I'd explain the synchronistic relations that demand this, but I didn't really understand that part myself… oh, and you might want to obtain a high-caliber firearm before attempting to take the measurements.  Just in case things start leaking into uhm… prime."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Outside",
    line = ccb.content.text("The recorder will beep once it has recorded enough data for a report.  The longer you stay outside, however, the higher the quality and quantity of the data will be.  While you are only expected to obtain the minimum viable report that the NRE can produce, we are willing to offer increased pay for higher-quality recordings."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Hold",
    line = ccb.content.text("You do not.  All that is required is that you have it somewhere on your person; it will function equally well inside of a bag as it would in your own hands.  Your preferred method of carrying the instrument will be enough to collect data as long as it is directly carried on your person."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Replacement",
    line = ccb.content.text("The recorder is not irreplaceable, but it is constructed using delicate components that are now in short supply.  In the event that the device is rendered nonfunctional, we are willing to provide a replacement at an equivalent cost.  Specifically, if you can locate an NRE microphone, which can be located in certain laboratories, then we are willing to provide a replacement recorder in exchange for it."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_ACCEPTED",
    line = ccb.content.text("Transferring the recorder now.\"  The intercom tray slides open, revealing a hefty, barebones device and a light battery to accompany it.  \"Please remember to exercise caution; the effects of portal storms on human physiology are poorly understood."),
}
