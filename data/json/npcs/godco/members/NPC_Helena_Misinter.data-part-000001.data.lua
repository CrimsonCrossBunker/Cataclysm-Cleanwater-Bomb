local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Firstmeet",
    line = ccb.content.text("I'm Helena, the caretaker of this flock.  Who might you be, wanderer?"),
    replies = {
        {
            text = ccb.content.text("I'm just passing through."),
            next_topic = "TALK_GODCO_Helena_Wanderer",
        },
        {
            text = ccb.content.text("I'm not doing much wandering, I'm staying here."),
            next_topic = "TALK_GODCO_Gemma_Firstmeet",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
        },
        {
            text = ccb.content.text("I'm just passing through.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
