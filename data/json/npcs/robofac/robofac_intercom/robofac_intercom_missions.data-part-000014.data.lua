local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_3_OFFER", "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
        "MISSION_ROBOFAC_INTERCOM_3_OFFER_Hesitating", "MISSION_ROBOFAC_INTERCOM_3_ADVICE_Location",
    },
    line = ccb.content.text("Our facility once sourced advanced photonic circuitry from a nearby robotics manufacturer.  Their building suffered major damage during the portal storms, and collapsed almost entirely.  However, preliminary scouting reveals that the basement prototyping lab likely remains intact.\"\n\n\"We ask you to investigate the ruins, and if possible, retrieve a template for the fabrication of said photonic circuitry.\"\n\n\"Completion of this contract awards 8 HGC, the standard heightened-hazard rate.  We are also willing to provide you with a set of protective gear at a considerable discount upon acceptance of the contract."),
    replies = {
        {
            text = ccb.content.text("Let's do this, then.  Transfer the location."),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_3") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ACCEPTED",
        },
        {
            text = ccb.content.text("Where is this manufacturer?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_Location",
        },
        {
            text = ccb.content.text("You mention hazard pay.  What dangers are there?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
