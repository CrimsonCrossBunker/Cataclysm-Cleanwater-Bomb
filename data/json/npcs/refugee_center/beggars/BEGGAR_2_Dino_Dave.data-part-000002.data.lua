local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_GIVE_FOOD",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("Oh nice.  Crunchings and munchings.  That's a cool, a cool thing."),
        no = ccb.content.gendered_line("Yeah, I'm real hungry and they put drugs in most of the food.  I can see you're not like that.", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry, I was wrong.  I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
    repeat_replies = {
        {
            categories = { "food" },
            reply = {
                text = ccb.content.text("Here, you can have this <topic_item>."),
                next_topic = "TALK_REFUGEE_BEGGAR_2_GAVE_FOOD",
            },
        },
    },
}
