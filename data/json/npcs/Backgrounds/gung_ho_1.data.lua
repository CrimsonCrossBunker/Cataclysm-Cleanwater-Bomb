local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GUNG_HO_1_STORY1",
    line = ccb.content.gendered_line("Nothin' special before <the_cataclysm>.  When the dead started walking, I geared up and started puttin' them back down.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("How did that go?"), next_topic = "BGSS_GUNG_HO_1_STORY2" },
        {
            text = ccb.content.text("Cool.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text("Cool.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GUNG_HO_1_STORY2",
    line = ccb.content.gendered_line("Almost got killed.  One <zombie> is easy pickins, but ten is a lot, and a hundred is a death trap.  I got myself in too deep, an' barely slipped out with my guts still inside me.  Holed up in an old motel for a while lickin' my wounds and thinkin' about what I wanted to do next.  That's when I figured it out.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Figured what out?"), next_topic = "BGSS_GUNG_HO_1_STORY3" },
        {
            text = ccb.content.text("Never mind.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text("Never mind.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GUNG_HO_1_STORY3",
    line = ccb.content.gendered_line("This is it.  This is what I was made for.  There in the street, smashin' monster heads and prayin' I'd make it out?  I've never felt like that.  Alive.  Important.  So after I got myself all stuck back together, I nutted up and went back to it.  Probly killed a thousand Z since then, and I'm still not tired of it.", { "interlocutor" }),
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
    id = "CWH_GUNG_HO_1_IDEAS1",
    line = ccb.content.text("Okay, y'know, I'm honestly gonna stop ya there.  Who gives a rat's ass?  I won't waste a second of time on thinkin' about that."),
    replies = {
        {
            text = ccb.content.text("Seriously?  You must have some idea."),
            next_topic = "BGSS_GUNG_HO_1_IDEAS2",
        },
        {
            text = ccb.content.text("Cool.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text("Cool.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_GUNG_HO_1_IDEAS2",
    line = ccb.content.text("What difference does it make?  Why waste brain cells on that?  I'm a finely tuned killing machine.  Point me at the zombies and I'll do my thing.  I don't want to get up in it, and find something that takes the magic out of it."),
    replies = {
        {
            text = ccb.content.text("I see.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text("I see.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}
