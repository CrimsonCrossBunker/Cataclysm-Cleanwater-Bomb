local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_MWS", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Reality_Bubble", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Recording_Length", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Replacement" },
    line = ccb.content.text("Your field NRE recordings are of continued interest of us.  Since you have proved yourself capable, we would like to expand your assignment.  We are willing to provide you with a mobile weather station.  We'd like you to set it up and deploy it near a portal storm.  A standard recording takes 1 hour.  We realize the anomalies may not last that long, so as long as the portal storm passes near the unit while recording, we can make use of the data.  As payment we will let you keep the weather system and pay you our standard subcontracting rate."),
    replies = {
        {
            text = ccb.content.text("More science?  I'm in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_1"), actions.handler("dlg_a_dda_7f37f3e7ae70") },
        },
        {
            text = ccb.content.text("How does the weather station work?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_MWS",
        },
        {
            text = ccb.content.text("Do I need to stay near the station while it records?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Reality_Bubble",
        },
        {
            text = ccb.content.text("How close do I need to get and do I need to record for the full hour?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Recording_Length",
        },
        {
            text = ccb.content.text("If I lose the station or break it, what should I do?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Replacement",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
