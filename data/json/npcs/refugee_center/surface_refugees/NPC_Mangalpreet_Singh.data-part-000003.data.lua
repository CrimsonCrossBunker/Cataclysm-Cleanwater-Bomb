local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_1a",
    line = {
        joined = {
            ccb.content.text("*gives you a solemn nod of recognition.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Hi there."),
                    ccb.content.text("Oh, hello there."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Mangalpreet."), next_topic = "TALK_REFUGEE_Mangalpreet_2" },
        {
            text = ccb.content.text("Hi Mangalpreet.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_1_firstmeet",
    line = ccb.content.text("Yes, I'm glad to meet you too.  Will you be staying with us?  I thought they were taking no more refugees."),
    replies = {
        {
            text = ccb.content.text("I'm a traveler actually.  Just saying hello."),
            next_topic = "TALK_REFUGEE_Mangalpreet_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_2",
    line = ccb.content.text("Is there anything you'd like to talk about?"),
    replies = { { text = ccb.content.text("Not really.  <end_talking_leave>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_Background",
    line = ccb.content.text("Before the end of the world, I was the vice principal of an elementary school.  Now, I'm not sure what I am.  A person without a purpose."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
