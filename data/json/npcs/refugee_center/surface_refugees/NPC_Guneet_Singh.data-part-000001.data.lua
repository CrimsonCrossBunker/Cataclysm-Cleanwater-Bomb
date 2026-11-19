local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_1a",
    line = {
        joined = {
            ccb.content.text("*turns away from the window, noticing you coming close.  \""),
            {
                choices = {
                    ccb.content.text("Hey there."),
                    ccb.content.text("Hi."),
                    ccb.content.text("Hey again."),
                    ccb.content.text("Oh, hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Gunny.  What's up?"), next_topic = "TALK_REFUGEE_Guneet_2" },
        { text = ccb.content.text("Hi Gunny.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_1_firstmeet",
    line = ccb.content.text("I guess we're still doing that stuff?  Cool.  Nice to meet you too.  What's up?"),
    replies = {
        {
            text = ccb.content.text("I just had some questions."),
            next_topic = "TALK_REFUGEE_Guneet_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_2",
    line = ccb.content.text("What's up?\"  He stares at you for a moment.  \"What a weird question.  The world ended.  That's what's up.  What am I supposed to answer to that one?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_Background",
    line = ccb.content.text("I was in high school, you know.\"  Gunny jabs his thumb at his shirt, which reads 'Alexander Bullock High'.  \"Most of the way through my junior year.  'My story'?  I got on a bus with my parents, the bus crashed, and everyone died except a few people, most of whom are crammed into this little shelter now.  Who knows when we're getting out."),
    replies = {
        {
            text = ccb.content.text("Your family all made it here?"),
            next_topic = "TALK_REFUGEE_Guneet_Family",
        },
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_Family",
    line = ccb.content.text("Yeah, we did.\"  He gestures to a turbaned older man, speaking quietly with a small woman a little way away.  \"Seems like it should be a great thing, right?  It is.  We're super lucky.  But I can't help feel like people blame us for it.  I keep wondering, y'know, 'why us'.  What makes me so special?  And how can I even enjoy this, when everyone around me is hurting so bad?"),
    replies = {
        {
            text = ccb.content.text("Is there something you could do to help the others?"),
            next_topic = "TALK_REFUGEE_Guneet_Help",
        },
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
