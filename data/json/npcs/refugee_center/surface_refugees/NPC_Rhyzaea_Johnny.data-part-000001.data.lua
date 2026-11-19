local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_1a",
    line = {
        joined = {
            ccb.content.text("*tilts her head in recognition as you approach.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Good to see you're still around."),
                    ccb.content.text("Oh, hi."),
                    ccb.content.text("Need to talk?"),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Rhy.  How's it going?"),
            next_topic = "TALK_REFUGEE_Rhyzaea_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_1_firstmeet",
    line = ccb.content.text("So, what's your story?  We don't see a lot of new people back here."),
    replies = {
        {
            text = ccb.content.text("Just a curious traveler.  What's up with you?"),
            next_topic = "TALK_REFUGEE_Rhyzaea_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_2",
    line = ccb.content.text("I'm doing as well as can be expected, I suppose.  Nice of you to ask."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_Background",
    line = ccb.content.text("It's a long, long story.  I'm not from around here, I'm actually from way out in Western Canada.  I'd always wanted to see New England, and I was down here on vacation when, well, you know.  I got evacuated, but because I'm not a US citizen they weren't willing to take me downstairs.  I can understand that, even if I don't like it much.  To tell you the truth I'm still coming to terms with the fact that I'll probably never know how my family and my band are doing."),
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background2",
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Family",
        },
        {
            text = ccb.content.text("Tell me about your band."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Band",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_Background2",
    line = ccb.content.text("I was a counselor actually, I worked for my band, Gitxsan.  Did a lot of mental health and addictions for people that had been through some really tough stuff.  Maybe not zombies eating your child level tough, but surprisingly not far off.  My people have gone through some real messy crap."),
    replies = {
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Family",
        },
        {
            text = ccb.content.text("Tell me about your band."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Band",
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
    id = "TALK_REFUGEE_Rhyzaea_Band",
    line = ccb.content.text("My band is Gitxsan, we're from Northwestern British Columbia, around the Skeena River.  I'm from Hazelton, myself.  It's a beautiful place.  Tall mountains, temperate rainforests… I partly came here because I love those wet coastal forests, and I love exploring them in other countries.  I've been to Korea and Slovenia for the same reason.  I guess I'm a bit of a forest tourist?  I don't know if I'll ever see my own forest again, and the thought breaks my heart."),
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background2",
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Family",
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
    id = "TALK_REFUGEE_Rhyzaea_Family",
    line = ccb.content.text("My mom and dad are back in Hazelton, they live with my grandma and my older brother; he took a hard knock to the head doing dumb things as a kid, and he can't really take care of himself now.  I have a daughter, Angel, she's sixteen and didn't want to come with me on this trip.  God help me, I can't bear to think of her, she must think I'm dead."),
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Background2",
        },
        {
            text = ccb.content.text("Tell me about your band."),
            next_topic = "TALK_REFUGEE_Rhyzaea_Band",
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
