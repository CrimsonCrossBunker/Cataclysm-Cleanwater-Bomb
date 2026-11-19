local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Skills",
    line = ccb.content.text("Yeah, I got a master's in computer science from the University of Rhode Island.  Everyone around here comes to me when they want to keep their computers running.  Corrie works more with the hardware portion of these things; I'd recommend visiting her."),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "general_training_olwen_can_teach", "yes") },
        },
    },
    replies = {
        { text = ccb.content.text("Could you teach me anything?"), next_topic = "TALK_TRAIN" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
