local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_WHAT_ELSE", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_LIXA_ACRONYM", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_Replacement", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_HEW" },
    line = ccb.content.text("During the Cataclysm, we lost contact with one of our sister sites, LIXA.  Aerial surveillance indicates that the facility's inhabitants are deceased, and beyond the now-zombified security detail, the site should be sparsely populated.  We want you to enter the facility and make a copy of what they were researching on the provided thumb drive.  Additionally, we will be providing you with a keycard that should at the very least get you in the front door.\"\n\n\"We're offering a standard 5 HGC for successful retrieval of the data.  If that isn't enough of an incentive, we do have a manifest from before we lost contact with the facility showing a handful of specialized powered suits in inventory.  You are free to take any that are left."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll see if I can't get that data for you."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"), actions.handler("dlg_a_dda_2f5e615d151c") },
        },
        {
            text = ccb.content.text("What can you tell me about what they were doing there?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_WHAT_ELSE",
        },
        {
            text = ccb.content.text("What does LIXA even mean?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_LIXA_ACRONYM",
        },
        {
            text = ccb.content.text("If I lose the ID card or the memory stick, what should I do?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_Replacement",
        },
        {
            text = ccb.content.text("You told me that the HEW system picked up \"spacetime anomalies\".  What does that mean?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_HEW",
            when = predicates.handler("dlg_p_dda_361ee57aaaf3"),
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

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
