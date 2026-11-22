local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER_ADVICE_HEW" },
    line = ccb.content.text("We've confirmed that the Hazardous Environment unit that you've recovered is in working condition.  We are willing to pay you a standard contracting fee to repeat your previous storm recordings."),
    replies = {
        {
            text = ccb.content.text("Alright, let's get a real recording this time."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_3_ACCEPTED",
            actions = { actions.handler("dlg_a_dda_55aec7df7093"), actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_3") },
        },
        {
            text = ccb.content.text("Anything different from last time?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER_ADVICE_HEW",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
