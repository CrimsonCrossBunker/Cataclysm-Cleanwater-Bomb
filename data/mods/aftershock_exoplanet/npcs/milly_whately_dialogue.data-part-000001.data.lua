local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_firstmeet",
    line = ccb.content.text("Millyficent Whately.  I'm so glad you finally arrived.  It's been a while since I last received new lab partners."),
    replies = {
        {
            text = ccb.content.text("I'm so hungry, can you help me?"),
            next_topic = "TALK_millyficent_food",
        },
        {
            text = ccb.content.text("You are aware of the Cataclysm?"),
            next_topic = "TALK_millyficent_cataclysm",
        },
        { text = ccb.content.text("I am your new lab partner."), next_topic = "TALK_Millyficent_1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_place",
    line = ccb.content.text("Welcome to my lab!  Here we explore the boundaries of the possible beyond the reach of small minds."),
    replies = {
        {
            text = ccb.content.text("Can you give me something to eat then?"),
            next_topic = "TALK_millyficent_food",
        },
        { text = ccb.content.text("Oh, okay."), next_topic = "TALK_Millyficent_1" },
        { text = ccb.content.text("I think there's been a mistake."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_food",
    line = ccb.content.text("No, no, no!  No food without successfully completed experiments.  We mustn't break the contract!"),
    replies = {
        { text = ccb.content.text("What do I have to do?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("I don't think you are well."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_ask_past",
    line = ccb.content.text("Well after I did my graduate thesis on theoretical xenobiology the government hired me to join the most interesting program.  Yes there were deaths but we learned so much."),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_Millyficent_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_cataclysm",
    line = ccb.content.text("What I know is that I pay well for test subjects and I deliver results and at this rate we will not be releasing on time!"),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_Millyficent_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_millyficent_ask_mood",
    line = ccb.content.text("Ever since they moved me to my own lab my research has progressed so much faster."),
    replies = { { text = ccb.content.text("This is not reassuring."), next_topic = "TALK_Millyficent_1" } },
}
