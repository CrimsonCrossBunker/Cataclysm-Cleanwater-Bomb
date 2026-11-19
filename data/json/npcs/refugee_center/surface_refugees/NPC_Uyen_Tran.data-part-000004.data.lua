local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_Teach",
    line = ccb.content.text("Sure, I don't see why not.  It's always good to have more people who can do it.  I'll need a bit of payment for my time, of course."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_flag_Uyen_teach", "yes") } } },
    replies = {
        { text = ccb.content.text("All right, let's do it!"), next_topic = "TALK_TRAIN" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
