local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY1",
    line = ccb.content.gendered_line("Well now, that's a hell of a story, so settle in.  It all goes back to about five years ago, after I retired from my job at the mill.  Times was tough, but we got by.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Okay, please continue."), next_topic = "BGSS_CODGER_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "BGSS_CODGER_STORY2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY2",
    line = ccb.content.text("That was when I had my old truck, the blue one.  We called 'er ol' yeller.  One time me an' Marty Gumps - or, as he were known to me, Rusty G - were drivin' ol' yeller up Mount Greenwood in the summertime, lookin' fer fireflies to catch."),
    replies = {
        { text = ccb.content.text("Fireflies.  Got it."), next_topic = "BGSS_CODGER_STORY3a" },
        {
            text = ccb.content.text("How does this relate to what I asked you?"),
            next_topic = "BGSS_CODGER_STORY3b",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "BGSS_CODGER_STORY3b",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY3a",
    line = ccb.content.text("Rusty G - that's my ol' pal Marty Gumps - were in the passenger seat with his trusty 18 gauge lyin' on his lap.  That were his dog's name, only we all just called him 18 gauge for short."),
    replies = {
        {
            text = ccb.content.text("18 gauge, the dog.  Got it."),
            next_topic = "BGSS_CODGER_STORY4a",
        },
        {
            text = ccb.content.text("I think I see some zombies coming.  We should cut this short."),
            next_topic = "BGSS_CODGER_STORY4b",
        },
        { text = ccb.content.text("Shut up, you old fart."), next_topic = "BGSS_CODGER_STORY4b" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY3b",
    line = ccb.content.text("Dammit I'm gettin' there, bite yer tongue.  As I was sayin', Rusty G - that's my ol' pal Marty Gumps - were in the passenger seat with his trusty 18 gauge lyin' on his lap.  That were his dog's name, only we all just called him 18 gauge for short."),
    replies = {
        {
            text = ccb.content.text("18 gauge, the dog.  Got it."),
            next_topic = "BGSS_CODGER_STORY4a",
        },
        {
            text = ccb.content.text("I think I see some zombies coming.  We should cut this short."),
            next_topic = "BGSS_CODGER_STORY4b",
        },
        { text = ccb.content.text("Shut up, you old fart."), next_topic = "BGSS_CODGER_STORY4b" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY4a",
    line = ccb.content.text("Now up the top o' Mount Greenwood there used to be a ranger station, that woulda been before you were born.  It got burnt down that one year, they said it were lightnin' but you an' I both know it were college kids partyin'.  Rusty G an' I left ol' yeller behind and wen' in to check it out.  Burnt out ol' husk looked haunted, we figgered there were some o' them damn kids rummagin' around in it.  Rusty G brought his 18 gauge, and lucky thing cuz o' what we saw."),
    replies = {
        { text = ccb.content.text("What did you see?"), next_topic = "BGSS_CODGER_STORY5" },
        {
            text = ccb.content.text("We really, really have to go."),
            next_topic = "BGSS_CODGER_STORY5",
        },
        { text = ccb.content.text("For fuck's sake, shut UP!"), next_topic = "BGSS_CODGER_STORY5" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY4b",
    line = ccb.content.text("Be patient!  I'm almost done.  Now up the top o' Mount Greenwood there used to be a ranger station, that woulda been before you were born.  It got burnt down that one year, they said it were lightnin' but you an' I both know it were college kids partyin'.  Rusty G an' I left ol' yeller behind and wen' in to check it out.  Burnt out ol' husk looked haunted, we figgered there were some o' them damn kids rummagin' around in it.  Rusty G brought his 18 gauge, and lucky thing cuz o' what we saw."),
    replies = {
        { text = ccb.content.text("What did you see?"), next_topic = "BGSS_CODGER_STORY5" },
        {
            text = ccb.content.text("We really, really have to go."),
            next_topic = "BGSS_CODGER_STORY5",
        },
        { text = ccb.content.text("For fuck's sake, shut UP!"), next_topic = "BGSS_CODGER_STORY5" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY5",
    line = ccb.content.text("A gorram moose!  Livin' in the ol' ranger station!  It near gored Rusty, but he fired up that 18 gauge and blew a big hole in its hide.  Ol' 18 gauge went headin' for the hills but we tracked him down.  Moose went down like a bag o' potatoes, but a real big bag iff'n y'catch m'drift."),
    replies = {
        { text = ccb.content.text("I catch your drift."), next_topic = "BGSS_CODGER_STORY6" },
        {
            text = ccb.content.text("Are you done yet?  Seriously!"),
            next_topic = "BGSS_CODGER_STORY6",
        },
        {
            text = ccb.content.text("For the love of all that is holy, PLEASE shut the hell up!"),
            next_topic = "BGSS_CODGER_STORY6",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY6",
    line = ccb.content.gendered_line("Anyway, long story short, I were headin' back up to Mount Greenwood to check on th' old ranger station again when I heard them bombs fallin' and choppers flyin'.  Decided to camp out there to see it all through, but it didn't ever end, now, did it?  So here I am.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Thanks for the story!"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("<name_b>."), next_topic = "TALK_DONE" },
    },
}
