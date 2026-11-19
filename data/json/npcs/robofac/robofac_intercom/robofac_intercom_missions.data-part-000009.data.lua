local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_2_OFFER", "MISSION_ROBOFAC_INTERCOM_2_ADVICE_Convoy",
        "MISSION_ROBOFAC_INTERCOM_2_ADVICE_DARPA",
    },
    line = ccb.content.text("When the portal storms started, the government issued an evacuation order for critical personnel and sent convoys to retrieve them, with our head of AI research among the recalled.  We recently discovered that he died when the convoy transferring him was ambushed in the initial chaos, but his corpse and belongings might remain intact enough to benefit from his research.\"\n\n\"We want you to travel to the convoy and locate the body, if possible.  His evacuation protocol included retrieving and storing as much of the data from his facility as possible, to be stored in a code-locked hard case.  If this hard case is present, retrieve it, and bring it back here.\"\n\n\"We offer the standard hazard pay of 4 HGC for this contract."),
    replies = {
        {
            text = ccb.content.text("I'll take it.  Where's the convoy?"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_2") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_ACCEPTED",
        },
        {
            text = ccb.content.text("What should I expect to go up against?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_Convoy",
        },
        {
            text = ccb.content.text("Who was this person, and what do they look like?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_DARPA",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
