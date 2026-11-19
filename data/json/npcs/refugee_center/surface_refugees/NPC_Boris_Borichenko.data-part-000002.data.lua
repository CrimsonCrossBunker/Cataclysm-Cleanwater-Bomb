local ccb = require("ccb")

-- Subsequent meetings with Boris before you have helped him finish some of his quests
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1a",
    line = {
        joined = {
            ccb.content.text("*stares at you for a moment before nodding in recognition.  \""),
            {
                choices = {
                    ccb.content.gendered_line("Well, well.  You are back.", { "speaker" }),
                    ccb.content.gendered_line("So, you have survived.", { "speaker" }),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Boris.  What's up?"), next_topic = "TALK_REFUGEE_Boris_2" },
        { text = ccb.content.text("Hi Boris.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

-- Later meetings with Boris, after you've started doing quests for him
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1b",
    line = {
        joined = {
            ccb.content.text("*nods at you, his eyes lighting up a little as you approach.  \""),
            {
                choices = {
                    ccb.content.gendered_line("Well, well.  I'm glad you are back.", { "speaker" }),
                    ccb.content.gendered_line("It is good to see you again, my friend.", { "speaker" }),
                    ccb.content.gendered_line("Hello, my friend.", { "speaker" }),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Good to see you, Boris.  Are things looking up for you at all?"),
            next_topic = "TALK_REFUGEE_Boris_3",
        },
        { text = ccb.content.text("Hi Boris.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1_firstmeet",
    line = ccb.content.text("It is nice to meet you too.  To what do I owe the pleasure?"),
    replies = {
        {
            text = ccb.content.text("I'm just a traveler, taking the chance to have some living human company.  What's up in your life these days?"),
            next_topic = "TALK_REFUGEE_Boris_2",
        },
        {
            text = ccb.content.text("I just wanted to say hi.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_2",
    line = ccb.content.text("What is 'up'?  Less than I would like, it seems.  I am better when I am busy, and I am not at all busy."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- This option is Boris' start point after you've finished his first mission and got to know him a bit.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_3",
    line = ccb.content.text("*forces a bit of a smile through his bushy beard, though it doesn't reach his eyes.  \"It is good to see you too.  I would not say things are looking 'up' yet, but they are not so much looking down perhaps.  I am keeping a bit busier.\""),
    replies = {
        {
            text = ccb.content.text("Want to talk about it a little?"),
            next_topic = "TALK_REFUGEE_Boris_Son",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
