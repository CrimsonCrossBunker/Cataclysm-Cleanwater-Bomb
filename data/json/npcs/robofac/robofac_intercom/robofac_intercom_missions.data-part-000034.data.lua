local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER",
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_DANGERS",
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_FIELD_TEAM",
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_SCAN_LOCATION",
    },
    line = ccb.content.text("The recording you brought us suggests that there is some underground source of alien organic volatiles.  We've cross-referenced with our existing geographic data, and we think we've identified several underground structures that may match the signatures you've brought us.  We'd like you and a field team to go to one of these and measure underground atmospheric conditions - with your HEW station, of course."),
    replies = {
        {
            text = ccb.content.text("Alright, so go underground to specific coordinates, set up the HEW station, and make a recording.  I'm in."),
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_FIELD_TEAM"),
                actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"),
            },
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_ACCEPTED",
        },
        {
            text = ccb.content.text("Any idea what I can expect?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_DANGERS",
        },
        {
            text = ccb.content.text("Field team?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_FIELD_TEAM",
        },
        {
            text = ccb.content.text("Do I need to scan at these EXACT coordinates?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_SCAN_LOCATION",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
