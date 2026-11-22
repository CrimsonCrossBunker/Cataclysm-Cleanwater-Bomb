local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_IVAS_OFFER", "MISSION_ROBOFAC_INTERCOM_IVAS_ADVICE_ANDURIL" },
    line = ccb.content.text("It has become clear that you and other agents required improved equipment for data collection and reconnaissance.  One of our surveillance teams has identified an Anduril Industries testing facility that we believe houses, or at least, housed, a prototype Military Visual Augmentation System.  It will resemble a consumer virtual reality headset, but has valuable hardware and software that we can use to develop useful tech for you and other mercenaries.  We want you to retrieve it and return it to us.\"\n\n\"We offer the standard hazard pay of 4 HGC for this contract, and we will grant you the honor of prototyping the first device, after we have studied it."),
    replies = {
        {
            text = ccb.content.text("I'll find it.  Where's this building?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_IVAS_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_IVAS"), actions.handler("dlg_a_dda_32fed1313479") },
        },
        {
            text = ccb.content.text("What is Anduril Industries?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_IVAS_ADVICE_ANDURIL",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
