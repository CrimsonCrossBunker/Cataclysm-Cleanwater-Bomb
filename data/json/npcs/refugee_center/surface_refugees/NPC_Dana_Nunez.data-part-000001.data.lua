local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_1",
    line = {
        joined = {
            {
                choices = {
                    ccb.content.text("*beams at you as you approach.  \""),
                    ccb.content.text("*turns from her conversation with Pablo, and smiles as she sees you.  \""),
                },
            },
            {
                choices = {
                    ccb.content.text("Hello, nice to see you again.  What brings you around today?"),
                    ccb.content.text("It's good to see you're still around."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi Dana, nice to see you too.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
