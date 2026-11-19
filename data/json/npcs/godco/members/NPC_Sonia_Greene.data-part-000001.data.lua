local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia_Instrument",
    line = ccb.content.text("You're damn right.  I like its scars, makes it look like it has a history, you know?  We've been through a lot.  Those pesky <zombies> forced me to harm my sweet, sweet guitar, but I retaliated and bashed their heads in!  I lost a part of me that day, but the guitar's alright.  Just a bit rusted from all that blood and gore, that's all."),
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
    id = "TALK_GODCO_Sonia_Chloe",
    line = ccb.content.text("Now that's a wild story.  I owe my life to this kid Chloe, really.  I'll let her tell the tale."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Sonia_Band",
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
    id = "TALK_GODCO_Sonia_Band",
    line = ccb.content.text("I was in an underground band - Taurists was our name - before all this.  Performing gigs at local venues and jamming with my friends; that's all my life was about.  Now, I'm a badass soloist with a war-torn guitar, a singer of the old-world preserving the wonders of music and the Taurist legacy for generations to come.  That's also a synonym for not having all that much going on in my life."),
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
    id = "TALK_GODCO_Sonia_Feeling",
    line = ccb.content.text("Oh, just fine.  A bit malnourished and all, but I can't really complain if that's the worst of it, right?  My guitar makes our twisted little world a bit more tolerable, though.  Takes my mind off stuff and muffles the screams of the boogeyman, you know?"),
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
    id = "TALK_GODCO_Sonia_Godco",
    line = ccb.content.text("Fairly?  There's no such thing as fairness in the world.  The NECC wouldn't give a damn if I starved to death on this very bench.  At least I have friends here, ones that appreciate what I do.  I make music and that's all I have left, it means everything to me."),
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
