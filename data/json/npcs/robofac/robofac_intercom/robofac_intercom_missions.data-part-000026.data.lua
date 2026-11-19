local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_MWS",
        "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_Dangers",
    },
    line = ccb.content.text("Unsurprisingly, the consumer-grade weather station malfunctioned during the storm recording.  Nevertheless, you've proved yourself a capable contractor.  Therefore, we'd like you to retrieve more advanced recording equipment.  Some time ago we lost contact with a DARPA-affiliated limnological test station, and we have reason to believe they kept sensitive recording equipment on hand.  We'd like you to retrieve it - for your standard contracting fee, of course."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll find the advanced weather recording equipment."),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_2") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_ACCEPTED",
        },
        {
            text = ccb.content.text("What does the equipment look like?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_MWS",
        },
        {
            text = ccb.content.text("Based on our previous work together, I'm guessing there may be some resistance?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_Dangers",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
