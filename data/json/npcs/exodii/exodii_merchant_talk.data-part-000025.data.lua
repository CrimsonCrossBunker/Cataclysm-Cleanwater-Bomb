local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus3",
    line = ccb.content.text("Just so, aye.  Again an' again, this'n has seen it.  Too many times."),
    replies = {
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
        },
        {
            text = ccb.content.text("Is it always like this?  What's going to happen to us?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- You want to get religious, eh?  I can't tell you for sure, but the people who claim to know, they talk about the Enemy.  Most folks have a fairy tale like that, I think.  A monster from ancient memory, returned.  I don't know much about that, but something makes those bodies walk and moan, and it doesn't seem to be anything human.  How it gets in, well, that's anyone's guess.  It can come the way we came, through a portal, but it doesn't always.  How it was for your world, I can't tell you.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
    line = ccb.content.text("F'r to wax religious, eh?\n\n*Rubik pauses for a while.  When they start talking again, their voice is slow and more serious than usual.*\n\nThis'n can't tell ye, rightly, but those what have a bottle an' a cork what fits it, they yark about the Enemy.  Most folks got a story like that in their ol' hearth-tales, an I'm ken.  A bad way, from times old, come back.  Ol' Rubik don't know much about that, but something makes them bodies walk and moan, and it don't seem to be somethin' of the way o' our kin.  How it gets in, well, that be anyone's for a guess.  It can come the way we came, wibbling and wobbling, but it don't always.  How it be'd the end for your deadland, Rubik can't say for ye."),
    replies = {
        {
            text = ccb.content.text("Wait, it can come like you did?  Did you bring this here?!"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause2",
        },
        {
            text = ccb.content.text("Is it always like this?  What's going to happen to us?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmCause2",
    line = ccb.content.text("No!  Bluster an' clouds, no!\"  Rubik's voice comes haltingly, as if they are picking their words with unusual care for clarity.  \"We done a few things what Rubik don't like to pickle an'… to think about, but never that!  We came after the fall, long after.  Always."),
    replies = {
        {
            text = ccb.content.text("Is it always like this?  What's going to happen to us?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- This is a deadland, you see.  Take a moment and look around, know what I mean?  What's left for you?  The dead will be in the fields, the forests, all over the world.  Anything that walks, they'll make it so it doesn't, and most will come back as undead.  Those that don't, the Enemy will change them as well.  Every deadland is the same.  You've years and more to go, but one way or another, this place is dead.  Though, as far as I can see, you've got quite a few years to go yet.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
    line = ccb.content.text("This be a deadland, kennit.  Spend a farthing at the pastor's house, d'ye razz?  What be left for ye?  The dead'll be in the fields, the forests, all around the green and brown.  Anything what walks, they'll salt 'n fallow, and most'll rise up and rejoin.  Those what don't, the Enemy twists and turns as well.  Every deadland be the same.  Ye've turns and twain, but come as it may, this land be dead.  Though, an I'm ken, ye've quite a few turns and twain to go yet."),
    replies = {
        {
            text = ccb.content.text("What then?  What happens after the whole planet dies?  Could it spread to other worlds from here?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline2",
        },
        {
            text = ccb.content.text("That's pretty hopeless talk.  I've killed a lot of zombies, I can beat this 'Enemy' too."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmTimelineTough",
        },
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
