local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Microphone",
    line = ccb.content.text("The microphone is a static version of the same device used in the recorder, mounted on a tripod.  The glass ampoule is larger, but should look roughly the same in design.  They may be somewhat scarce given the current state of the world, but I would advise you to look inside of research labs.  Subway lines may be a good place to start."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Complete",
    line = ccb.content.text("&You fold up the microphone's legs, stuff it awkwardly into the tray, and slide it shut.  A few moments later, it slides open again, revealing a replacement NRE recorder.\n\n\"Try not to lose this one.\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CONTRACTS_NoneAvailable",
    line = ccb.content.text("Give me a moment to look at your file… here we are.  Valid assignments are turning up empty at the moment.  I'm afraid we have no open contracts for you."),
    replies = { { text = ccb.content.text("Understood."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}
