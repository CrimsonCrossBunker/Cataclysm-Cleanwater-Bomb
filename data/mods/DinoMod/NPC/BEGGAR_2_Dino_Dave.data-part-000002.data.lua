local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_DINO_Directions",
    line = ccb.content.text("Wait, what if I'm the probe?  What if you're the probe?  Let me mark that on your map nice and big."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_FAKE_DAVE") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for the information.  I'd better go."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I was the probe the whole time."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
    },
}
