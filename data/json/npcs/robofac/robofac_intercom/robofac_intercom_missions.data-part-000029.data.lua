local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE",
    line = ccb.content.text("Anywhere there is portal activity, or where you think portal activity occurred in the recent past.  If you happen to find yourself transported to… exotic places… that would also be a good time to make recordings."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_FRAME",
    line = ccb.content.text("It is a 3D-printed pack frame, much like those used to move equipment for more… traditional field work.  We've designed an ergonomic frame to accommodate your HEW unit, a small tent, a rollmat, as well as waterproof compartments for essential electronics: one UPS, one folding solar panel, and one standard laptop.  It is cumbersome, and you won't be able to store anything in it other than the specific equipment, but it is lightweight and efficient.  We will provide only frame and some solar panels for field charging your HEW unit."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_NRE",
    line = ccb.content.text("We believe we can integrate the units, which may make it easier for you to make complex recordings on the move."),
}
