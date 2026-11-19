local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Story",
    line = ccb.content.text("I arrived a bit later than everyone else, I was at my studio when <the_cataclysm> came.  Had to dodge a big horde of <zombies> on my way out of town, totaled my car, and hiked the rest of the way."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Past",
    line = ccb.content.text("I always wanted to be a fashion designer when I was young.  I used to have a set of dolls, and I'd make dresses for them out of spare cloth I could find.  I took up sewing in high school, and I was trying to get a job with Fashion Nova before <the_cataclysm> screwed that up."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Feeling",
    line = ccb.content.text("Things are alright, could be better.  I've been mending clothes and sheets ever since I arrived, fixing this and that.  Theresa's been a big help in those regards, we've traded quilt patterns and designs quite a bit."),
    replies = {
        {
            text = ccb.content.text("Could you tell me about Theresa?"),
            next_topic = "TALK_GODCO_Maria_Theresa",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Theresa",
    line = ccb.content.text("She's a kind old lady, does a lot of knitting.  She could probably make you something if you asked nicely."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
