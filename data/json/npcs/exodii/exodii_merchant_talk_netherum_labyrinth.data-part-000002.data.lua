local ccb = require("ccb")

-- A word of caution: I can't tell you what you'll find.  They're always different.  Don't trust them.  Don't linger.  Use your head, think like an Exodii:  take what you can, but don't get tempted by treasure.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how2",
    line = ccb.content.text("Last word o' threat:  Can't know what ye'll find there.  They're ever a bit different for each'n'all.  Trust not.  Tarry not.  Use yer lump and think as'n Exodii:  take what ye can, but be not tempted by treasure."),
    replies = {
        {
            text = ccb.content.text("It's clear you've been there, Rubik.  What was it like, really?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how3",
        },
        { text = ccb.content.text("Thanks Rubik, I'll be careful."), next_topic = "TALK_DONE" },
    },
}

-- For me?  Well, twisted halls of steel.  But there's another place.  It's a little like a pub I barely remember, if it ever existed.  Warm.  Wood.  Fire.  Like a Temple (this should be capitalized, as it's what it calls itself for Rubik) for the soul, if I still have one.  But I don't stay there or trust it.  These days, I don't even visit.  I have other things to do, like run this shop.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_how3",
    line = ccb.content.text("Fer me?  Well, twisting halls of steel, like this place, or that.  But there's another place.  A mite like a rub-a-dub house ol' Rubik scarce remembers, if it ever were.  Warm.  Wood.  Fire.  The ol' Temple for the soul, if there's any yet left.  Yet I tarry not there, trust it not a hair.  In fact, these days, I jus' don't go.  Got other things to do, like run this skip n' hop."),
    replies = {
        {
            text = ccb.content.text("I'm not sure that clears it up, but thanks Rubik, I'll be careful."),
            next_topic = "TALK_DONE",
        },
    },
}
