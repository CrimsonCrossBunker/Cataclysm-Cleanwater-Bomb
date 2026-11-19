local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_TALK" },
    line = ccb.content.text("What do you wish to discuss?"),
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_VAMPIRE_MENTOR_SELF" },
        { text = ccb.content.text("What is this place?"), next_topic = "TALK_VAMPIRE_MENTOR_PLACE" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("What did you meant by \"mentor\"?"),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
