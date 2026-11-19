local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_FEMA_EVACUEE_1_IDEAS1",
    line = ccb.content.gendered_line("Woof, you ready for a real hot take?  The <freaking> government did this to us.  Intentionally, or at least sort-of intentionally.", { "speaker" }),
    replies = {
        { text = ccb.content.text("Oh?"), next_topic = "CWH_FEMA_EVACUEE_1_IDEAS2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_FEMA_EVACUEE_1_IDEAS2",
    line = ccb.content.text("Damn right.  They lied to us for god knows how long about what was going on because they didn't want us to figure it out.  It probably started as a way to keep the people in line, but it backfired somehow.  My guess is they tried to de-educate us, tried to mislead us, and when that wasn't working they tried actual drugs in the water to make us stupid or something.  Instead of just stupid, some people got violent.  Then they tried to leverage that to put in martial law, but that didn't work and they wound up fighting hordes of people.  Only they didn't realize their <freaking> brain drugs were some kind of mutagen that turn people into zombies."),
    replies = {
        {
            text = ccb.content.text("What about all the other stuff?"),
            next_topic = "CWH_FEMA_EVACUEE_1_IDEAS3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_FEMA_EVACUEE_1_IDEAS3",
    line = ccb.content.text("I think it's mostly mutation.  I don't know what they used, but it's some real mad science shit, I didn't think most of this was even possible.  I also wonder if whatever they put in the water has made us a bit crazy.  Maybe some of this is just a hallucination?  That one blows my mind a bit, I'm not sure I believe it but I got nothin' else."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
