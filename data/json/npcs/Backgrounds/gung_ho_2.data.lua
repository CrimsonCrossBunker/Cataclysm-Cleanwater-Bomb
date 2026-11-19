local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GUNG_HO_2_STORY1",
    line = ccb.content.gendered_line("Oh, you know.  Blah blah blah, had a job and a life, everyone died.  Boo hoo.  I gotta be straight with you though: I honestly think I like this better.  Fighting for survival every day?  I've never felt so alive.  I've killed hundreds of those bastards.  Sooner or later one of them will take me out, but I'll go down knowing I did something actually important.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("It's good you found your calling.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("It's good you found your calling.  <end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_GUNG_HO_2_IDEAS1",
    line = ccb.content.text("We-e-e-ell now, that's a fun one.  I haven't got a single solid idea, you know?  But whatever made it start, I think the goop is behind it all."),
    replies = {
        {
            text = ccb.content.text("The goop?  What do you mean?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS2a",
        },
        {
            text = ccb.content.text("What are your other ideas?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS2b",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_GUNG_HO_2_IDEAS2a",
    line = ccb.content.text("Those zombies are just spitting it.  Goop, black tarry stuff coming out their eyes and nose and mouth.  Whatever it is, it's what's making them walk again.  Somehow doesn't seem to be too contagious, I got tons of it on me… still not a zombie.  And then there are those goopy monsters around, whatever they are, I think they're connected.  Maybe they're behind it, or maybe they're something else caused by the same stuff.  Dunno, but mark my words: it's the goop."),
    replies = {
        {
            text = ccb.content.text("Is all this just based on the goop from zombies being black and slimy, like the black slimes?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS3",
        },
        {
            text = ccb.content.text("What are your other ideas?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS2b",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_GUNG_HO_2_IDEAS3",
    line = ccb.content.text("You got any better ideas?  Besides, not like there's any teacher checkin' our work.  Maybe I'm wrong, don't really give a shit.  But the zombies and those slime things showed up about the same time, and they both have this connection to black goo, so I'm stickin' to my guns."),
    replies = {
        {
            text = ccb.content.text("What are your other ideas?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS2b",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_GUNG_HO_2_IDEAS2b",
    line = ccb.content.text("Oh, probably the same stuff everyone's thinking.  No special ideas.  Like, maybe this is some kind of military superweapon gone wrong.  Or maybe the world just is like this every so often, and that's what killed the dinosaurs.  Who knows."),
    replies = {
        {
            text = ccb.content.text("What were you saying about goop?"),
            next_topic = "BGSS_GUNG_HO_2_IDEAS2a",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
