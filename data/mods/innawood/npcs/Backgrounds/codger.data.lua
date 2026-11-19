local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY1",
    line = ccb.content.text("Well now, that's a hell of a story, so settle in.  It all goes back to about five years ago, back when the willows hadn't come in all the way and the old stream was a little more reliable.  Times was tough, but we got by."),
    replies = {
        { text = ccb.content.text("Okay, please continue."), next_topic = "BGSS_CODGER_STORY2" },
        {
            text = ccb.content.text("On second thought, let's talk about something else."),
            next_topic = "BGSS_CODGER_STORY2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY2",
    line = ccb.content.text("That was when I had my old pistol, the blue one.  We called 'er ol' yeller on account of the war.  One time me an' Marty Gumps - or, as he were known to me, Rusty G - were messin' with ol' yeller up Mount Greenwood in the summertime, lookin' fer something to shoot and some fireflies to catch."),
    replies = {
        { text = ccb.content.text("Fireflies.  Got it."), next_topic = "BGSS_CODGER_STORY3a" },
        {
            text = ccb.content.text("How does this relate to what I asked you?"),
            next_topic = "BGSS_CODGER_STORY3b",
        },
        { text = ccb.content.text("I need to get going."), next_topic = "BGSS_CODGER_STORY3b" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY3a",
    line = ccb.content.text("Rusty G - that's my ol' pal Marty Gumps - were there with his trusty boom stick lyin' on his lap.  That were his dog's name, only we all just called him boom stick for short."),
    replies = {
        {
            text = ccb.content.text("Boom stick, the dog.  Got it."),
            next_topic = "BGSS_CODGER_STORY4a",
        },
        {
            text = ccb.content.text("I think I see some giant ants coming.  We should cut this short."),
            next_topic = "BGSS_CODGER_STORY4b",
        },
        { text = ccb.content.text("Shut up, you old fart."), next_topic = "BGSS_CODGER_STORY4b" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY3b",
    line = ccb.content.text("Dammit I'm gettin' there, bite yer tongue.  As I was sayin', Rusty G - that's my ol' pal Marty Gumps - were in the passenger seat with his trusty boom stick lyin' on his lap.  That were his dog's name, only we all just called him boom stick for short."),
    replies = {
        {
            text = ccb.content.text("Boom stick, the dog.  Got it."),
            next_topic = "BGSS_CODGER_STORY4a",
        },
        {
            text = ccb.content.text("I think I see some giant ants coming.  We should cut this short."),
            next_topic = "BGSS_CODGER_STORY4b",
        },
        { text = ccb.content.text("Shut up, you old fart."), next_topic = "BGSS_CODGER_STORY4b" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CODGER_STORY4a",
    line = ccb.content.text("Now up the top o' Mount Greenwood there used to be a nice campin' place, that woulda been before you were born.  Whole area burnt up that one year, they said it were lightnin' but you an' I both know it were just kids partyin'.  Rusty G an' I left ol' yeller behind and wen' in to check it out.  Burnt out woods looked haunted, we figgered there were some o' them damn kids rummagin' around in there, neckin' or whatnot.  Rusty G brought his boom stick, and lucky thing cuz o' what we saw."),
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
    line = ccb.content.text("Be patient!  I'm almost done.  Now up the top o' Mount Greenwood there used to be a nice campin' place, that woulda been before you were born.  Whole area burnt up that one year, they said it were lightnin' but you an' I both know it were just kids partyin'.  Rusty G an' I left ol' yeller behind and wen' in to check it out.  Burnt out woods looked haunted, we figgered there were some o' them damn kids rummagin' around in there, neckin' or whatnot.  Rusty G brought his boom stick, and lucky thing cuz o' what we saw."),
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
    line = ccb.content.text("A gorram moose!  Livin' right up there in that burnt up spot!  It near gored Rusty, but he fired up that boom stick and blew a big hole in its hide.  Ol' boom stick went headin' for the hills but we tracked him down.  Moose went down like a bag o' potatoes, but a real big bag iff'n y'catch m'drift."),
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
    line = ccb.content.text("Anyway, long story short, I were headin' back up to Mount Greenwood to check on th'old campin' place again when I heard all that trouble start.  Decided to camp out there to see it all through, but it didn't ever end, now, did it?  So here I am."),
    replies = {
        { text = ccb.content.text("Thanks for the story!"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("…"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("<name_b>."), next_topic = "TALK_DONE" },
    },
}
