local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro",
    line = ccb.content.text(
        --~ Ahh, now that's a big question.  Not something I'd share with anyone who wandered in.  But yes, I know, you have one of our interfaces.  You carry our trust with you, and maybe you have the right to know.
        "Ahh, now that be a weighty ask.  Not a thing ol' Rubik shares wi' every soul as wanders in, mind.  But aye, I know it, clear as day - that ye've the interface set in ye proper.  Ye carry the work in ye own flesh, so mayhaps ye've the right o' it, fair an square."),
    replies = {
        {
            text = ccb.content.text("I'm glad you trust me.  Tell me more."),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro2",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro2",
    line = ccb.content.text(
        --~ Listen carefully:  not everything we gather comes from places like this.  Sometimes, we find places we call "labyrinths."  Stairs down to other worlds.  We keep track of them.  And, one is nearby, spotted by Benzete themselves.  These places aren't safe, and they aren't friendly.  But, they seem made for us, which is convenient, if you don't think too hard about it.  Honestly, it's where most of our bionics come from.
        "Hear it true:  not all we gather is from these otherlands, and otherlands like it.  At times, we happen by places this'n might call \"labyrinths.\"   Apples an' pears down to otherlands, in their own right.  The Exodii keeps the reckonin'.  An there's one \"nearby\", so t'speak, spotted by Benzete 'emself.  These places have no safe ground, an nothin' there be friendly.  Yet the ones we find seem made fer us'n.  Right convenient, if ye don't press it o'er hard.  Truth be, it's where most'o'our bright an' steelies comes from."),
    replies = {
        {
            text = ccb.content.text("So these \"labyrinths\" are like other worlds?  But not?  What ARE they?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_what",
        },
        {
            text = ccb.content.text("How would I get to these \"labyrinths\"?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_what",
    line = ccb.content.text(
        --~ What are they, you ask?  If I knew, I'd be afraid to say.  They aren't like other places.  They don't just exist.  Something put them there, piece by piece.  A workshop of unknown purpose.  But also, not like any of that.  Honestly, not really sure if they exist before we pass by, or through them, anyway.  Anything we say about them is basically waxing religiously - maybe they can't be explained.
        "What are they, ye ask?  If ol' Rubil could name it clean, mayhaps I even wouldn'.  They ain't like other otherlands.  Not places what simply are.  Willed, these.  Set.  As if some vast mind laid'em out, piece by piece.  A labor-hall built for a purpose this'n don't ken.\"\n\nRubik pauses and scratches at their chin.\n\n\"But also… well, not like any o' that, neither.  Truth be, not rightly sure they're there before we pass by, or through 'em, any road.  By and by, what us'n says o' such places is waxin' religious, more than tellin'.  Mayhap they can't be known proper."),
    replies = {
        {
            text = ccb.content.text("So, they seem like someone made them?  But also, not really?  What kinds of things do you find there?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_what2",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_what2",
    line = ccb.content.text(
        --~ You find all manner of things.  But, you walk in and there are things where you might not expect them to be.  Tools ready to use.  Bionics ready to take, like bait on a snare, too tempting.  Listen carefully: you won't find gifts there.  You are a thief in the night, stealing what you want.  You're a fish, and the treasures are hooks.
        "Ye find all manner of things - treasures in troves.  But, ye trapse in, an' things where they oughtn't.  Tools laid ready.  Bright an' steelies waitin' like a snare, too fair.  Mark ol' Rubik well:  what ye find there ain't gifts.  Yer a tea leaf in the night, nickin' what you want and can.  Yer a fish, and the treasure's a hook."),
    replies = {
        {
            text = ccb.content.text("What makes these things?  Is it whatever is raising the dead?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_what3",
        },
        {
            text = ccb.content.text("So, how would I get to these \"labyrinths\"?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_what3",
    line = ccb.content.text(
        --~ No, not The Enemy, but something like their wife (Rubik is trying to be funny).  If you go, you'll see.  It'll talk to you.  It knows what shape to take, or it just takes it, anyway.  For me, an old friend, in a Temple of ale I barely remember.  For others, other things.  But, if it starts talking to you in a familiar way?  It it offers you safety?  Leave, quick and quiet.  It's a lie.  Death by another name.
        "No, not The Enemy, but might be their trouble n' strife.  If ye' go, just wait n' see.  It'll ask.  It knows what shape to wear, or it just takes it, anyhow.  For me, an ol' friend, in the Temple of ale this'n scarce remembers.  For others, other things.  But, if it starts answerin' ye in a way just for you?  If it offers ye' a safety you think this broken world don't have?  Best be on yer way, quick and quiet.  It's a lie.  Just death by another name."),
    replies = {
        {
            text = ccb.content.text("Trouble and strife?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_trouble_strife",
        },
        {
            text = ccb.content.text("So, how would I get to these \"labyrinths\"?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_trouble_strife",
    line = ccb.content.text(
        --~ Heh, just trying to be funny, when I shouldn't be.  A bad joke.  Nothing funny about it.  I meant only this: it isn't the Enemy the one that raises the dead here.  But, they're maybe similar in some way.  Not family, not part of the Enemy, but maybe an equal to it.  So don't take the joke for more than a joke.  It's not its partner, its wife, or its friend, because I doubt these things have such things.  Maybe just an illusion - a trick in the head.  But that's just my thinking - it's all unknown.
        "Heh, just ol' Rubik tryin t'be clever, where clever can't be called for.  A poor jest, at that.  Nothin' funny in it.\"\n\nRubik's tone becomes a bit more somber - more serious.  \"I meant only this:  it's not The Enemy what walks among the dead, but mayhaps say she's cut from the same cloth.  Not kin, not part of it, but this'n reckons alike, yet in its own fashion.  So don't take the jest for more than it be.  Ain't really a wife, friend, of anything of the sort, 'cause there ain't any such thing.  Mayhaps all an illusion - a jape of the lump.  But that's just my thinkin'.  Mayhaps."),
    replies = {
        {
            text = ccb.content.text("Okay, so whatever lives there is some sort of interdimensional horror.  Or maybe not.  Great.  How would I get to these \"labyrinths\"?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}
