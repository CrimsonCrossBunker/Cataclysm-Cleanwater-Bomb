local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Love0",
    line = ccb.content.text("Of course, our relationship was going pretty well before <the_cataclysm>.  Olwen seems to be under the weather lately, but I want to give her a great surprise and make her smile again…"),
    replies = {
        {
            text = ccb.content.text("Want me to help you with that surprise?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Love1",
    line = ccb.content.text("With a big smile and her eyes wide open!  I can't thank you enough for helping me with that, even so…  You could maybe lend your hand again to bring even more happiness to this place?"),
    replies = {
        { text = ccb.content.text("What do you need?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Love2",
    line = ccb.content.text("She loved it!  I still can't believe I will be able to provide her with a proper wedding even after everything that happened, you have been a real life saver <name_g>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Mutant_Join",
    line = ccb.content.text("Listen, I have some bad news.  I don't personally have anything against you, but many of the people here are very… discriminatory against those who look like you.  I hate to say it, but I'll have to turn you away.  I'm sorry."),
    replies = {
        {
            text = ccb.content.text("Alright, let's talk about something else."),
            next_topic = "TALK_GODCO_Julian_2",
        },
        { text = ccb.content.text("I get the picture, screw this."), next_topic = "TALK_DONE" },
    },
}
