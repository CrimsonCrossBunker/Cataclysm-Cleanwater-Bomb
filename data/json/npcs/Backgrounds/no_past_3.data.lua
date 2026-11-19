local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_3_STORY1",
    line = ccb.content.gendered_line("This is gonna sound crazy, but I woke up in the forest in the middle of nowhere, freezing cold, about a week before I met you.  I had my clothes, a splitting headache, and absolutely no memory of anything.  Like, I know stuff.  I can talk, I have skills and understanding… but I don't remember where any of it comes from.  I had a driver's license in my pocket and that's the only way I even know my name.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What do you think happened?"),
            next_topic = "BGSS_NO_PAST_3_STORY2",
        },
        {
            text = ccb.content.text("That does sound a little crazy…"),
            next_topic = "BGSS_NO_PAST_3_CRAZY",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_3_STORY2",
    line = ccb.content.text("There were some clues.  Like, I had a nasty headache that lasted a few days, but no cuts or bruises.  And there were scorch marks on the trees in weird slashing patterns around me.  Whatever happened to me, I think it was some weird shit."),
    replies = {
        {
            text = ccb.content.text("Are you trying to get your memory back then?"),
            next_topic = "BGSS_NO_PAST_3_STORY3",
        },
        {
            text = ccb.content.text("That does sound a little crazy…"),
            next_topic = "BGSS_NO_PAST_3_CRAZY",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_3_STORY3",
    line = ccb.content.gendered_line("Well, not having a memory is weird as heck, but I'll be honest: I think it might be better?  With what's going on, I bet you my memories weren't happy ones.  Besides my driver's license, there were pictures of kids in my wallet… not that that sparked any reaction from me.  I didn't see any kids around.  Maybe losing my mind is a mercy.  Hell, maybe it's some kind of psychotic break and my brain did this to itself.  To be honest with you I think I'd rather focus on surviving, and not worry about it.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("That does sound a little crazy…"),
            next_topic = "BGSS_NO_PAST_3_CRAZY",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_3_CRAZY",
    line = ccb.content.gendered_line("I know it's nuts.  It sounds like fake amnesia from a Bugs Bunny cartoon.  See?  How can I know that, but not remember how I know it?  Like, I remember Bugs Bunny but I don't remember any time I sat down and watched a Bugs Bunny show.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
