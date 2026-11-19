local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro",
    line = {
        joined = {
            ccb.content.text("Them as offer as can, an it be so.  How'd ye be twigged by a quick an' round, a nice escoltin' out to a place sommat of curiosity?  Aye, there's summat the old Scythy been larkin' up Rubik's tailpipe.  B'ain't tass right for a clanker like this'n, but a pop-an-work like you'n, maybe well and suited."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Just because you asked, I think we can work something out.  Yes, the Scythean has been bugging me about something.  It's not something a cyborg like me can do, but a mercenary would probably fit the bill."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_explain",
    line = {
        joined = {
            ccb.content.text("Hat ye kennt our great clanks an' stompers?  There be many a thing we can do right good, but for the supple an' smooth, we b'ain't.  Wish'n we to make a meet-cute, must we first lay out the hempen mats."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Have you seen our big stompy quads?  There's a lot of things we're good at, but sneaky and subtle we aren't.  If we want a meet cute, first we've got to lay out the hempen mats."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro1",
    line = {
        joined = {
            ccb.content.text("It be a right coddle to yark, but ol' Rubik'll do as can.  Them as we send a'far, what I'd assert as 'escolts'… explorers?  They's escolted a place with a mite o' promise, an I'm ken.  A wall o' crete-stone, abreast a rattlin' clunker… a 'bunker'.  Not so odd in a deadlands alas, but this'n gots the comin's and goin's.  Sommat's still in there, an' ol' Rubik wonders who.  Be they friend or foe?  What say ye t'helpin' with a mite o' escoltin' y'self?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("It's a bit hard to explain, but I'll do my best.  The forces we send far out, what I'd call 'escolts'… explorers?  They've scouted a place with a bit of promise, as far as I can tell.  A wall of concrete around a bunker.  That's not so odd in a place like this, but this one has people coming and going.  There's something still in there, and I wonder who.  Are they friendly or not?  What would you think about doing some scouting yourself?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro2",
    line = {
        joined = {
            ccb.content.text("No, me fruit gum, no!  Make no contact, y'ken?  This be covert.  If ye kennit be safe, traipse along an' for a kennabout, but upon the chimes, speak none and tarry little."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("No, my friend, no!  Don't make contact, understand?  This is a covert op.  If you see that it's safe you can go in closer and look around, but for goodness' sake, don't talk to anyone and don't linger."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro3",
    line = {
        joined = {
            ccb.content.text("Them as we've escolted seems a fair kin, an' we've eyed a scav or two wanderin' the premise unscathed.  If'n the scavs o' the dust can make it in an' out, so should ye be."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Our scouts have seen people who look like you wandering in the area safely.  If the scavengers can make it in and out, you should be fine."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_pay_skeptic",
    line = {
        joined = {
            ccb.content.text("Rightly a trig barter, an I'm ken.  By ol' Rubik's word, on your saintly march home, for you'll have the pick of the bright and steelies roun' ol' Rubik's shop, choice o' your own finely.  What say?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("I didn't know you'd be such a hard bargain!  Tell ya what, when you come back, I'll let you in on some of these fancy knick-knacks."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_pay_nice",
    line = {
        joined = {
            ccb.content.text("Ah, 'tis a fine spark.  F'r a switch an' clock, ol' Rubik can share y'like o' these bright and steelies roun' the shop, choice o' your finely.  What say?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("That's quite the spirit!  For an exchange, I'll give you some of these shiny tools, whatever you want.  How's that sound?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_met_hub",
    line = {
        joined = {
            ccb.content.text("Ah, would ye be willin' ta yark with me about it?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Ah, would you be willing to tell me about it?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_complete",
    line = {
        joined = {
            ccb.content.text("'Tis a fine an' dandy!  What can ol' Rubik stand ye for, then?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("That's great!  What would you like as payment?"),
        },
    },
}
