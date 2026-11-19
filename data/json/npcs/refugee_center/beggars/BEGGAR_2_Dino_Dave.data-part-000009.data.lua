local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_JOIN",
    line = ccb.content.text("No!  I just got everything together.  I am not leaving, not now.  Everything's finally coming together!"),
    replies = {
        {
            text = ccb.content.text("Well, OK then, Dave.  One last favor, I think I can talk to Smokes about finding you a place to go."),
            actions = { actions.assign_mission("MISSION_BEGGAR_2_PERMISSION") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll have to think on it, Dave, I've done a lot already."),
            next_topic = "TALK_DONE",
        },
    },
}
