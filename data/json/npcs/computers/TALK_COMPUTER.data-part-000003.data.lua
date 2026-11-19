local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_DISABLE_EXTERNAL_POWER",
    line = ccb.content.text("--ACCESS GRANTED--\nMission Complete!"),
    replies = {
        {
            text = ccb.content.text("Press any key."),
            next_topic = "COMP_REFUGEE_CENTER_MAIN",
            actions = { actions.finish_mission("MISSION_OLD_GUARD_NEC_COMMO_2", { step = 1 }) },
        },
    },
}
