local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GUNG_HO_2_STORY1",
    line = ccb.content.text("Oh, you know.  Blah blah blah, had a life, everyone died.  Boo hoo.  I gotta be straight with you though: I honestly think I like this better.  Fighting for survival every day?  I've never felt so alive.  I've killed hundreds of those bastards.  Sooner or later one of them will take me out, but I'll go down knowing I did something actually important."),
    replies = {
        {
            text = ccb.content.text("It's good you found your calling.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("It's good you found your calling.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_GUNG_HO_2_IDEAS2b",
    line = ccb.content.text("Oh, probably the same stuff everyone's thinking.  No special ideas.  Like, maybe this is some kind of weapon gone wrong.  Or maybe the world just is like this every so often, and that's what killed the dinosaurs.  Who knows."),
    replies = {
        {
            text = ccb.content.text("What were you saying about goop?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS2a",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
