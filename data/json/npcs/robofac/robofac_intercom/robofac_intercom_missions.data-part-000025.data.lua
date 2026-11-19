local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_MWS",
    line = ccb.content.text("The station is a self-contained meteorology unit.  You will have to haul it to the location and construct it, but it's rather simple.  The assembly process takes the average person about twenty minutes.  After that, start the recording subroutine using the onboard computer.  After recording, remove the printed datasheet.  Again, simply set it up and start recording while a portal storm is around, and we'll be able to make use of the data."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Reality_Bubble",
    line = ccb.content.text("You do not.  This is expensive technology in short supply, so you may wish to defend it from anomalous interference.  But the device can hypothetically be left and collected later."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Recording_Length",
    line = ccb.content.text("You do need to have the storm, in some capacity, be active near the unit while it is recording.  But, we do not expect you to record from the eye of the storm, nor does the storm need to be active for the full hour.  As long as you capture some data it will suffice.  We caution you not to shut off the device early - allow it to finish the 1 hour recording subroutine so that it prints useable data."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Replacement",
    line = ccb.content.text("While these are infinitely easier to construct than your NRE recorder, the components are still in short supply.  We will be able to issue replacements through our normal surplus trade, so you may have to wait for some time.  Be careful with it."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_ACCEPTED",
    line = ccb.content.text("Transferring the weather station now.\"  The intercom tray slides open and thunks, revealing a yellow, hard-plastic case with a sturdy handle.  \"As in your previous assignment, please remember to exercise caution during these storms, especially with the delicate equipment."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_COMPLETE",
    line = ccb.content.text("Fantastic.  Just a moment.\"  The intercom's tray slides shut.  There is a very long silence, and then it opens again, this time with your payment.  \"You have our thanks and your payment.  Unfortunately, this equipment seems to have malfunctioned in the storm.  We will need more sensitive equipment to proceed.  If you'd like another contract, we're prepared to make an offer."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
