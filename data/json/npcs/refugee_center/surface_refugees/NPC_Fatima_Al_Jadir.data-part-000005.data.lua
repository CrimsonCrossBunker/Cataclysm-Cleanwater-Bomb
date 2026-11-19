local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Teach_yesbarter",
    line = ccb.content.text("Oh, fine, you weasel.  I suppose I can manage for 3 notes.  I seriously can't go lower though, we'll be using up my resources and time and I gotta pay for the gas and the food somehow."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "barter_flag_Fatima_barter_success", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
