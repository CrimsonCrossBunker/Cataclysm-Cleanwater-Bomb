local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_1_STORY3",
    line = ccb.content.text("Not exactly.  After a while, I got brave.  I started venturing into the swamps, picking off giant bugs here and there.  I learned about traveling in at night to avoid a bunch, and that got me pretty far.  Eventually I cleared out a cozy little area for myself and started really feeling comfortable.  I guess I got a bit complacent."),
    replies = {
        { text = ccb.content.text("Complacent?"), next_topic = "BGSS_EVACUEE_1_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_1_STORY4",
    line = ccb.content.text("I thought I had those damned bugs figured out.  I got braver, started heading out by day more and more.  A bunch of deer and a bear had turned and chased me down.  It was brutal.  I got out of there, but I had to leave everything and start over."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_1_IDEAS1",
    line = ccb.content.text("What happened?  I'm not really sure.  You must know about the riots and all that, that the leadership totally failed to contain.  I don't have a good guess what caused that.  I thought it was the usual stuff at first, and I gotta admit, I was sort of excited and scared it was the start of a revolution.  Not excited enough to join in though, and I guess anyone who was is probably dead now.  I tried to wait it alone, packed a little bag, but I saw a rioter get back up and fight with crazy injuries.  I don't know how many people really believed it at first, but I took that as my sign and ran for a nearby cave I knew.  I don't know exactly what happened after that.  I thought others would be there but it was just me."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
