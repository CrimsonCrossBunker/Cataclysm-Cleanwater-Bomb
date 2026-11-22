local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Joinee",
    line = ccb.content.text("You are most welcome here.  In the good old days we would've held a ceremony for you.  Oh well, times have changed.  Accept this blanket, you may choose either bed by the window.  If you're hungry, you can go see Simon for a meal, up to one per day."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_a026e5b0762a"), actions.set_actor_value("speaker", "general_meeting_godco_joinee", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you.  See you around, Gemma."),
            next_topic = "TALK_DONE",
        },
    },
}
