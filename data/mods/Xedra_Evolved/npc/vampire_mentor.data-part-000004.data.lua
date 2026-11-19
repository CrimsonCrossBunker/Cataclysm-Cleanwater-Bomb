local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SELF" },
    line = ccb.content.text("I am an old vampire, wishing to see more embrace and develop that gift."),
    replies = {
        { text = ccb.content.text("I want to talk."), next_topic = "TALK_VAMPIRE_MENTOR_TALK" },
        { text = ccb.content.text("What is this place?"), next_topic = "TALK_VAMPIRE_MENTOR_PLACE" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_PLACE" },
    line = ccb.content.text("It's a safe place for the blood-drinkers.  Here, it's only them, their servants and their food.  And also those who wish to become blood-drinkers themselves."),
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_VAMPIRE_MENTOR_SELF" },
        { text = ccb.content.text("I want to talk."), next_topic = "TALK_VAMPIRE_MENTOR_TALK" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
