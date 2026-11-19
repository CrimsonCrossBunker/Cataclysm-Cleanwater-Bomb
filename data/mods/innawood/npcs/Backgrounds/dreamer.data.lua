local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_DREAMER_STORY1",
    line = ccb.content.text("OK, this is gonna sound crazy but I, like, I knew this was going to happen.  Like, before it did.  You can even ask my psychic except, like, I think she's dead now.  I told her about my dreams a week before the world ended.  Serious!"),
    replies = {
        { text = ccb.content.text("What were your dreams?"), next_topic = "BGSS_DREAMER_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_DREAMER_STORY2",
    line = ccb.content.text("OK, so, the first dream I had every night for three weeks.  I dreamed that I was running through the woods with a stick, fighting giant spiders.  For reals!  Every night."),
    replies = {
        {
            text = ccb.content.text("OK, that doesn't seem that unusual though."),
            next_topic = "BGSS_DREAMER_STORY3a",
        },
        {
            text = ccb.content.text("Wow, crazy, I can't believe you really dreamed <the_cataclysm>."),
            next_topic = "BGSS_DREAMER_STORY3b",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_DREAMER_STORY3a",
    line = ccb.content.text("OK, that's just, like, the beginning though.  So, a week before it happened, after the spider dream, I would get up and go pee and then go back to bed 'cause I was kinda freaked out, right?  And then I'd have this other dream, like, where my friend died and came back from the dead!  And then, a few days later, my friend's husband was visiting and he got sick and I heard the next day that he'd come back from the dead!  Just like in my dream, only it was a different person!"),
    replies = {
        { text = ccb.content.text("That is kinda strange."), next_topic = "BGSS_DREAMER_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_DREAMER_STORY3b",
    line = ccb.content.text("RIGHT?!  And there's more!  So, a week before it happened, after the spider dream, I would get up and go pee and then go back to bed 'cause I was kinda freaked out, right?  And then I'd have this other dream, like, where my friend died and came back from the dead!  And then, a few days later, my friend's husband was visiting and he got sick and I heard the next day that he'd come back from the dead!  Just like in my dream, only it was a different person!"),
    replies = {
        { text = ccb.content.text("That is kinda strange."), next_topic = "BGSS_DREAMER_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
