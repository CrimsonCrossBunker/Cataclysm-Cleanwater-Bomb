local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_Background",
    line = ccb.content.text("*narrows her eyes, her words coming out hoarse and clipped.  \"You can't just go asking people questions like that nowadays.  I'm a teenaged girl alone in an evacuation center after, like, literally everyone in the world died and came back as zombies.  What do you think my story is?  My entire family died, came back as zombies, and I somehow wound up here.\""),
    replies = {
        {
            text = ccb.content.text("Who takes care of you here?"),
            next_topic = "TALK_REFUGEE_Aleesha_Background_caretaker",
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
    id = "TALK_REFUGEE_Aleesha_Background_caretaker",
    line = ccb.content.text("Nobody really.  I'm old enough to work and get merch for my rations.  Jenny and Rhy look out for me though.  They think I don't notice that they're looking out for me, but I do.  It's okay, they're both cool."),
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_Situation",
    line = ccb.content.text("I don't have much of a hot take besides what I just said.  It's shit.  Not enough to do to stay busy, not enough to eat, and even if I had internet, all the YouTubers I follow are dead."),
    replies = {
        {
            text = ccb.content.text("What YouTubers did you follow?"),
            next_topic = "TALK_REFUGEE_Aleesha_Background_influencers",
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
    id = "TALK_REFUGEE_Aleesha_Background_influencers",
    line = ccb.content.text("*looks you up and down, an uncharacteristic glint of humor in her eyes.  \"Why, you thinking of subscribing?  I don't think you'd have heard of them, and even if you had, there's definitely no way for them to get any new content out.  Not anything worth watching anyway.\""),
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
