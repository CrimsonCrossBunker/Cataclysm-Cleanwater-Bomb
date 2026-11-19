local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Story",
    line = ccb.content.text("If you're here for an exciting story, you're talking with the wrong person.  Ever since I was born I've lived very modestly.  Did I regret it?  No, it will all be worth it in the end…"),
    replies = {
        {
            text = ccb.content.text("Tell me about the community."),
            next_topic = "TALK_GODCO_Katherine_Community",
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_GODCO_Katherine_Family",
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
    id = "TALK_GODCO_Katherine_Community",
    line = ccb.content.text("I've been a member of the New England Church Community for a quarter of a century, took part in each and every sermon and gathering they held even while I was carrying my boy Jeremiah.  Not to mention the countless times we visited those filthy homeless shelters and prisons filled with sinners.  I even met the Founder himself.  I can confidently say I'm more worthy to be here than those impostors who leech on us at this camp."),
    replies = {
        { text = ccb.content.text("The Founder?"), next_topic = "TALK_GODCO_Katherine_Founder" },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_GODCO_Katherine_Family",
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
    id = "TALK_GODCO_Katherine_Family",
    line = ccb.content.text("I'm sure you've met my husband, Simon.  He was also a volunteer at a homeless shelter, working as a cook.  We were brought together by the hands of fate as some would say.  We have a son together, Jeremiah, the light in my life.  Such a creative and well-behaved boy, I just wish we could find an appropriate woman for him."),
    replies = {
        {
            text = ccb.content.text("Tell me about the community."),
            next_topic = "TALK_GODCO_Katherine_Community",
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
    id = "TALK_GODCO_Katherine_Founder",
    line = ccb.content.text("He was quite reserved when I met him, seemed distant in his thoughts.  Theresa has the answers you are looking for."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll talk to her then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Angry",
    line = ccb.content.text("Look, I'm rather upset and just need some time alone, okay?  I'm sure you're very busy."),
    replies = {
        {
            text = ccb.content.text("I don't have the time to wait, now can we get on with business?"),
            next_topic = "TALK_GODCO_Katherine_Angry_Pressed",
        },
        { text = ccb.content.text("Okay, I'll see you later."), next_topic = "TALK_DONE" },
    },
}
