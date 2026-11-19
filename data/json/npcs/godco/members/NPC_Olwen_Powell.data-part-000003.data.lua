local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_2",
    line = ccb.content.text("What's up?"),
    replies = {
        {
            text = ccb.content.text("Can you teach me anything?"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_training_olwen_can_teach" } }),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("Is there anything I can help you with?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
