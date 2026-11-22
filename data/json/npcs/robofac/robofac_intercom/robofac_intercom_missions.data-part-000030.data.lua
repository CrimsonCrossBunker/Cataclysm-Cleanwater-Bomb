local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE", "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_FRAME", "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_NRE" },
    line = ccb.content.text("We believe your HEW unit can produce scientifically useful recordings near many types of of anomalous, extra-dimensional activity - not just portal storms.  In fact, we now know that it is equipped with a small, and relatively simple DARPA AI program trained on extensive data collected before… recent events.  It is capable of producing reports for anomalies and relating them to previously studied laboratory phenomena - anomalies it can assign unique codes to, which we can then interpret using our supercomputers.  If you can bring us these reports, we will pay you for them.  We will also pay for more portal storm recordings.  To facilitate your work, we can offer you two things.  First, we are prepared to give you a custom-printed pack frame, which will allow you to carry your HEW station and some essential supplies.  Secondly, if you are willing to pay, we would be willing to put R&D time into integrating your NRE recorder with your HEW unit."),
    replies = {
        {
            text = ccb.content.text("Well, I guess you can call me the weatherperson.  I'm in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_ACCEPTED",
            actions = { actions.handler("dlg_a_dda_e0b22c7c9d72"), actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_4") },
        },
        {
            text = ccb.content.text("What sorts of places should I be looking for?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE",
        },
        {
            text = ccb.content.text("Tell me more about this custom frame."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_FRAME",
        },
        {
            text = ccb.content.text("Tell me more about the HEW-NRE unit."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_NRE",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
