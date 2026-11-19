local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Mood",
    line = ccb.content.text("We're doing better than most, to put it mildly.  There's a reason for that, as for everything.  Say, have I told you about my husband?  I'm sorry if I already have, my memory's not what it used to be."),
    replies = {
        {
            text = ccb.content.text("Tell me about your husband."),
            next_topic = "TALK_GODCO_Theresa_Husband",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Husband",
    line = ccb.content.text("He was an exceptional man.  Ever since he was a child it was clear that there was something special about him.  My husband had a way with people, and with God too.  But, after all he was as human as you and I.  He was corrupted by addiction.  One day, God appeared to him in a vision that turned his life around, he had other plans for him.  From then on he didn't take his life for granted.  He used his talent and newfound inspiration to better the people around him."),
    replies = {
        {
            text = ccb.content.text("So, he founded the community?"),
            next_topic = "TALK_GODCO_Theresa_Community",
        },
        {
            text = ccb.content.text("Tell me about his visions."),
            next_topic = "TALK_GODCO_Theresa_Vision",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Community",
    line = ccb.content.text("That's right.  He wanted something to return for the guidance he received when he was at the lowest point of his life.  He created a charity group which, over the years, became what's now known as the New England Church Community.  He lead them for many decades, until his death a few years before his prophecy was fulfilled.  Now, our niece Helena leads the community."),
    replies = {
        {
            text = ccb.content.text("Tell me about his visions."),
            next_topic = "TALK_GODCO_Theresa_Vision",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Vision",
    line = ccb.content.text("He was a man of many secrets.  It would've been too personal to share, I'm afraid.  On the other hand, there was a prophecy he was quite vocal about.  In a way, he predicted <the_cataclysm> long before the first warning signs appeared.  Thanks to him, we had the foresight to prepare.  Oh what a great man he was…"),
    replies = {
        {
            text = ccb.content.text("So, he founded the community?"),
            next_topic = "TALK_GODCO_Theresa_Community",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Story",
    line = ccb.content.text("Oh you don't have the time for that, do you now?  It's a long, long tale, thank goodness.  I'm grateful, for I was blessed with a full life."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Help",
    line = ccb.content.text("That's very sweet of you <granny_name_g>, but there's nothing I could possibly want from this mortal world.  My life is now complete, I believe."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit",
    line = ccb.content.text("Yes, I knit and sew in my spare time.  Its' helped keep my hands in good shape over the years."),
    replies = {
        {
            text = ccb.content.text("Could you make something for me?"),
            next_topic = "TALK_GODCO_Theresa_Knit_Something",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
