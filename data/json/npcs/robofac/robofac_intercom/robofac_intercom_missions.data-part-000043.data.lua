local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_WHAT_ELSE",
    line = ccb.content.text("All I can tell you is that they were conducting cutting-edge research related to-\" The intercom abruptly cuts off for several seconds before coming back on, the voice sounding apologetic, \"Sorry, but as it turns out I'm not at liberty to divulge that information.  What I can do however is recommend you bring an NRE recorder with you if you still have one."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_LIXA_ACRONYM",
    line = ccb.content.text("It's an acronym that stands for Laser Interferometer eXodimensional resonance Array."),
}

-- I feel like this could be phrased better.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_Replacement",
    line = ccb.content.text("Well, the ID card wouldn't strictly speaking be necessary if you were to find some way of breaching the facility's security doors.\" The voice pauses for a moment, \"But that said we only have the one ID card, so unless you're confident you can get in without it, please don't lose it.  As for the memory stick I would highly recommend you not lose that as portable drives with the required hardware security modules to interface with secure terminals are in short supply these days.  However there may very well be some on-site for you to scavenge if you're lucky."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_HEW",
    line = ccb.content.text("&You hear a click as the microphone shuts off.  After several seconds it clicks back on, someone taps the microphone twice to test it - thud thud - and then speaks: \"All I can tell you is that you may encounter extradimensional anomalies, but we cannot be certain which.  I strongly recommend you take an NRE recorder.\""),
}

-- Is it a semi-colon or colon that goes here? Man, idk.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_ACCEPTED",
    line = ccb.content.text("Transferring the items now.\"  The intercom tray slides open, revealing an ID card for the facility and what looks like a USB thumb drive.  \"Again: please take care not to lose either of these since we can't exactly make more of them."),
}
