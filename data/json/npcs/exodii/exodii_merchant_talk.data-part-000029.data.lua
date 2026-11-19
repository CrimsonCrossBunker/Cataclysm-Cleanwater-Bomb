local ccb = require("ccb")

-- Ah, good question.  Enough cybernetic implants can keep someone from coming back as a zombie, but it's not a sure thing.  Some come back anyway, and some just don't have enough cybernetics.  Most of them aren't full Exodii like old Rubik, they're more our friends - like you.  Sooner or later we'll get out there, put them down, and bring their parts back for cleaning.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Zomborgs",
    line = ccb.content.text("'Tis a good an' yark, sooth.  Them as can have the metal deep in, can be saved for the risen, but it b'ain't a sure course.  Some as comes back anyway, an' some be too much flesh.  The grander lot are no Exodii like ol' Rubik, most be friends more kin to thyself.  Us'll hearken out and trundle home the pieces for a scrub-and-bucket."),
    replies = {
        {
            text = ccb.content.text("So you use these cybernetics to prevent zombification, but they don't work perfectly?  Why not?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Make",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- I don't think I'm the best to explain that, but I'll do my best.  Our technology might seem pretty high-tech and well made to you, but on the inside I'm still mostly human meat bound up in wires and steel.  Nobody's left that remembers exactly how it all goes, and much of it is cobbled together from a few different dimensions.  It's a miracle they work as well as they do, but somehow it's actually pretty functional.  Still, it can be hard to know exactly what could go wrong.  The ones who come back as zombies, they're generally less well made than me.  Some even did their own cybernetic conversions, and didn't exactly follow best practices.
-- Lore note: Rubik is an unreliable narrator here, by giving part-truths.  Nothing here is a lie but they're omitting some important details.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Make",
    line = ccb.content.text("Rubik's not the finest dandy to yark it, an I'm ken, but this'n'll do best as can.  Ol' Rubik an' the stompy-clanker gang be shiny an' fine as can be, for y'see so well, but on the wind-up, the guts be nigh so fleshy as they were afore, twixt as they be with wire and steel.  Ain't none so left as remembers precise how it all goes, and much is boggled from bits and drabs o' a dozen elsewheres.  'Tis a marked fine they work at all, though work they do, and nicely.  Still, 'tis hard to know what'll crumple out from the can.  Those as return, they be… less well made as ol' Rubik.  Some as did work themselves, even, and mayhap against the good old ways."),
    replies = {
        {
            text = ccb.content.text("You seem to have a lot of standardized robotic helpers, like those quads.  Is that a different thing?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Quads",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Ah, they're an inbetween, but more machine than meat.  We use the softer bits of other critters for those, but the walker itself is printed.  It's complicated.
-- Rubik is not giving you the whole story here and will avoid giving you the whole story unless you force them.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Quads",
    line = ccb.content.text("*'s tone changes slightly, sounding a bit pained.  \"Ah, them be an in-between, more machiner.  Us'n use the softer bits o' other critters for them, an' there be a manufactory for the walker.  A hard but needed choice.\""),
    replies = {
        {
            text = ccb.content.text("How long does it take you to make one of these walkers?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Make_Time",
        },
        {
            text = ccb.content.text("Can I buy one of your machines?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Buy",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Faster than you might guess, but it can still take a while, the hardest part is sourcing the materials for one.  We've got printers that make the body, and others that make the tools and equipment the walker will use.  Some of the special parts have to be manufactured by hand, so we have a small team that does that.  Right now, it's very slow, we're still setting up our operations.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Make_Time",
    line = ccb.content.text("Blinker than a bat, but downer than a cat.  Razzin' up the bits be a trick and some.  The draw-make automates can manufactorize the outer shell, and there be automates for the most o' the tools.  Some bits be more a breakfast o' rats, an' for them, us'n has some artisanals.  Us'n b'ain't on the solid now, so 'tis a longer down."),
    replies = {
        {
            text = ccb.content.text("Can I buy one of your machines?"),
            next_topic = "TALK_EXODII_MERCHANT_Robot_Buy",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
