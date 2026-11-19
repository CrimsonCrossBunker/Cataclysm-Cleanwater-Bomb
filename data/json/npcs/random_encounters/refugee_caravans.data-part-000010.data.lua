local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Directions",
    line = ccb.content.text("Sure, I can mark it on your map if you like.  Here."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for the tip!  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks for the tip!  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
