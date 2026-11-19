local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_GENERIC",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_SPIRAL_MADMAN_SPIRALS",
        },
        { text = ccb.content.text("Sorry, what?"), next_topic = "TALK_SPIRAL_MADMAN_SPIRALS" },
        { text = ccb.content.text("I'm outta here.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_SPIRALS",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("Why are you repeating 'spirals' over and over again?"),
            next_topic = "TALK_SPIRAL_MADMAN_R_U_NUTS",
        },
        { text = ccb.content.text("Sorry, what?"), next_topic = "TALK_SPIRAL_MADMAN_R_U_NUTS" },
        { text = ccb.content.text("I'm outta here.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_R_U_NUTS",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("Are you nuts?"),
            next_topic = "TALK_SPIRAL_MADMAN_THIS_IS_MADNESS",
        },
        {
            text = ccb.content.text("Sorry, what?"),
            next_topic = "TALK_SPIRAL_MADMAN_THIS_IS_MADNESS",
        },
        { text = ccb.content.text("I'm outta here.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_THIS_IS_MADNESS",
    line = ccb.content.text_without_extraction("<spirals>"),
    replies = {
        {
            text = ccb.content.text("Poor fellow - looks like you're out of your mind.  Can't help you, sorry.  I'm outta here.  Bye."),
            next_topic = "TALK_DONE",
        },
    },
}
