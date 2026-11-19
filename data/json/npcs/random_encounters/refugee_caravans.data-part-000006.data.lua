local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A_CENTER",
    line = ccb.content.text("Here, I'll mark it on your map.  I wouldn't bet they'll treat you any differently than us though.  You might try and bring something to trade, they like that."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Can you give me directions to where you're going too?  I love cartography."),
            next_topic = "TALK_CARAVAN_REFUGEE_A_FEMA",
        },
        {
            text = ccb.content.text("Thanks for the information.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1",
    line = ccb.content.text("Looking good there.  I like your whole setup.  What's your story?"),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_REFUGEE_B2") } } },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_REFUGEE_B1_Job",
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_DONE" },
    },
}
