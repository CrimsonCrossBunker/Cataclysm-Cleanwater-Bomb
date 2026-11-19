local ccb = require("ccb")

-- Until the normal world is covered in alien biomes and then all falls to dust.  That's just how it goes.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora2" },
    line = ccb.content.text("Til the green and brown be yellowred and blue afore it be to grey and black.  'Tis the course."),
    replies = {
        {
            text = ccb.content.text("Is there any way to stop it?  Can we cut them down or burn them or something?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora_burn",
        },
        {
            text = ccb.content.text("The course?  What's going to happen?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
        },
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- You could burn it, but the portals will just bring it back.  No, there's no stopping it at this point.  Even if you burned every single one you found, you're just one person and there's an endless supply of them, so it's futile.  There's only one way this goes.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora_burn" },
    line = ccb.content.text("Aye, mayhap, but more'll dribble through the wobbles.  You can't athwart all o' the bridges.  If'n you light each and every, you're only one against many.  'Twould be no point.  The road only goes one way."),
    replies = {
        {
            text = ccb.content.text("Well, we'll see about that.  Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- Many times.  It doesn't always go the same, and sometimes they only show up right before we leave the world, but they always do.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_alien_flora_source" },
    line = ccb.content.text("Time an' time.\"  Rubik pauses for a moment.  \"There be eddies and ripples, aye, an' sometime they come just afore we make to wobble on, but they surely do."),
    replies = {
        {
            text = ccb.content.text("Is there any way to stop it?  Can we cut them down or burn them or something?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora_burn",
        },
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I've gotta go.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
