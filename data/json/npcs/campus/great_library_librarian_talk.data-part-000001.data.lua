local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
    line = {
        choices = {
            ccb.content.text("Always glad to help another reader."),
            ccb.content.text("Never stop learning."),
            ccb.content.text("I just love books."),
        },
    },
    replies = {
        {
            text = ccb.content.text("About other things…"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("Let me see what you have."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("When will you have new material?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskedRestock",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AskedRestock",
    line = {
        choices = {
            ccb.content.text("It can be hard to predict the way things are now, but I am expecting new materials around <restock_time_point>."),
            ccb.content.text("I am expecting some new materials around <restock_time_point>, hopefully some good escapism."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("Thanks, I will make sure to check back."),
            next_topic = "TALK_DONE",
        },
    },
}
