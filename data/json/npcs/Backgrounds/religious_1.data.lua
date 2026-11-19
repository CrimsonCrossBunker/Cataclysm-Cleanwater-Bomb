local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_RELIGIOUS_1_IDEAS1",
    line = ccb.content.text("It's clear enough, isn't it?  That… that end, was the Rapture.  I'm still here, and I still don't understand why, but I will keep Jesus in my heart through the Tribulations to come.  When they're past, I'm sure He will welcome me into the Kingdom of Heaven.  Or… or something along those lines."),
    replies = {
        {
            text = ccb.content.text("I meant more the actual events.  What happened?"),
            next_topic = "CWH_RELIGIOUS_1_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_RELIGIOUS_1_IDEAS2",
    line = ccb.content.text("Oh.  Well, I think it follows the good word in Revelations, if I remember right.  I haven't talked to a preacher in a bit, you know.  There were the plagues… the first one was the one a couple years ago, that big pandemic, that was when people started talking about the end being near.  Then there was a plague of blood, or was it violence?  That was the riots.  Then the seas turned red with blood, that was from all the people being shot.  Then a plague of fire, I remember that one for sure, that was when there were bombs and things going off everywhere to try to contain the riots.  And then demons and monsters walked the Earth, and the dead rose from their graves, and finally the meek inherited.  Clear as day."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
