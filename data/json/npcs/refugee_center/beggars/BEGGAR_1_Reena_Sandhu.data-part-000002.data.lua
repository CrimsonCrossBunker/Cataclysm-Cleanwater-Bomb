local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
    line = ccb.content.text("Thank you so much."),
    replies = {
        { text = ccb.content.text("Can I ask you something else first?"), next_topic = "TALK_NONE" },
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
                next_topic = "TALK_REFUGEE_BEGGAR_1_GAVE_FOOD",
            },
        },
    },
}
