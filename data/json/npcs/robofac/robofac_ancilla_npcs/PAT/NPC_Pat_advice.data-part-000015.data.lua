local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_RUBIK_ANUS_FETICK",
    line = ccb.content.text("Easy: the fahkin' hospital, ya' fahkin' stunad, hah!  Heah, I'll upload a map to one neahby."),
    replies = {
        {
            text = ccb.content.text("Thanks, mabye I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_HOSPITAL"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_hospital", "yes"),
            },
        },
    },
}
