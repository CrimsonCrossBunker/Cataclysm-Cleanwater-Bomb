local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_2",
    line = ccb.content.text("Gathering sand sounds, honestly, sort of pleasant.  Like, meditative, you know?  Maybe we find some batteries and get a bit of music going, smoke a joint if you're so inclined, then fill some buckets of sand for Eddie to do whatever the hell he's doing with it.  No zombies, no gunfire, just sand."),
    replies = {
        {
            text = ccb.content.text("I believe he's making bricks.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_3",
    line = ccb.content.text("I like a good, well defined physical job.  Let's go to the riverside!  I feel like the odds of getting badly injured while gathering clay are sort of low.  Make sure to get some music going though, right?  Maybe bring some refreshments?  And shovels."),
    replies = {
        {
            text = ccb.content.text("You do make it sound good.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_1",
    line = ccb.content.text("Big jars aren't really that uncommon.  Lots of people got super into canning in the last few months before shit really hit the fan, like they did with toilet paper a few years back.  Maybe a bit more reasonable, I guess, though learning how to pickle meat probably didn't save anyone from zombies.  I bet we can track down a few just by raiding houses, and if they're not empty we'll just have to eat what's inside or something."),
    replies = {
        {
            text = ccb.content.text("Do you need a snack, man?  Never mind.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_2",
    line = ccb.content.text("I'm sort of surprised they don't have plenty of wheat seeds of their own,\" Liam shrugs.  \"What the hell do I know about farming though?  Nothing, that's what.  Including having no idea about where to find wheat seeds, sorry man.  I would have said 'on a farm' but we're on one and they're asking us, so I just don't know what to think anymore.  My life is a shambles."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_1",
    line = ccb.content.text("You know, it's a harmful stereotype that wolves are dangerous to humans.  Of course I'm not afraid.\"  He smirks at you, then grins.  \"Except let's be honest, this is probably going to be a giant monster zombie wolf or something, right?  Let's go take the bastard down."),
    replies = {
        {
            text = ccb.content.text("That's the spirit.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_2",
    line = ccb.content.text("Fast, unidentified monsters are killing the local wildlife, and we're going to get 'em.\"  He looks thoughtful.  \"I'm pretty sure this was an episode of the X-Files.  Or like, several episodes?  As long as we're Scully and Mulder we'll be fine, but if we're the local cops coming in to investigate, we're *toast*.  Just in case, let's make sure we've got our good gear."),
    replies = {
        {
            text = ccb.content.text("Will do, Scully.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_1",
    line = ccb.content.text("Funny you should ask, yeah I have.  My dad borrowed it from the library once and I leafed through it.  So I guess we could try looking at a library?  I got no better ideas, I was like thirteen, I don't remember what was in the thing, and he got all pissy at me for checking it out anyway."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_2",
    line = ccb.content.text("Well, yeah he does, because he's a man of discerning tastes.\"  Liam nods approvingly.  \"Or because he wants something to prop his car up while he changes the tire.  It's a big book, is what I'm saying.  We should make sure we've got a copy for ourselves though, it's one of the prepper bibles."),
    replies = {
        {
            text = ccb.content.text("Great info, thanks.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1",
    line = ccb.content.text("*leans in close, speaking softly.  \"I do not say this lightly: this motherfucker has *seen some shit*.  Look at that thousand-yard-stare.  We did a good thing getting him out, but I don't know if he's ever really gonna be *out*, you know?\""),
    replies = {
        {
            text = ccb.content.text("Do you think we can do anything for him?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help1",
        },
        {
            text = ccb.content.text("He'll suck it up.  We've all been through shit."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-toughlove",
        },
        {
            text = ccb.content.text("Scary stuff.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help1",
    line = ccb.content.text("We can get him home in one piece.  Get him back to his people.  I'd offer him a drink or a toke, but I think they're like, Amish or something.  After that, our best bet is to make ourselves scarce, to him we're always gonna be the people he met in the tower.  He won't wanna be reminded of that."),
    replies = {
        {
            text = ccb.content.text("How do you know so much about this?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help2",
        },
        {
            text = ccb.content.text("Scary stuff.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help2",
    line = ccb.content.text("*looks abruptly uncomfortable.  \"You know a bit about me and my dad, right?  I went to counseling for a few years after I got out.  Since what went down with Chris, I've been thinking about it more too.\"  He shakes his head.  \"We could all use a decent counsellor, honestly.  Even before the world ended.\""),
    replies = {
        {
            text = ccb.content.text("Thanks, man.  You have layers.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-toughlove",
    line = ccb.content.text("Yeah, I guess we have.\"  Liam looks off into the distance for a moment.  \"We sure fuckin' have."),
    replies = {
        {
            text = ccb.content.text("Damn straight.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RADIO",
    line = ccb.content.text("&He laughs.  \"Heck yeah, my friend, I picked that up here and there running deliveries for Amazon, during my famously long breaks.\"  He grins.  \"Seriously though, I hope it's something obvious, like a big disconnected dish.  Even if we can't figure it out, I'm looking forward to climbing up there, I love that shit.  Seems like a nice fun one.\""),
    replies = {
        {
            text = ccb.content.text("Cool.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
    line = ccb.content.text("*stares at you.  \"I'm leaving that one to you.  I can't believe I was excited for that mission, that critter was *weird*.  I guess it did make it easy to figure out what was going on though, so that's cool right?\""),
    replies = {
        {
            text = ccb.content.text("Yeah, 'cool'.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_1",
    line = ccb.content.text("How do you think I'm feeling?  *Amazing* of course.  Can I hold the EMP grenades?  Please?\"  He lightens up his grin, just a little.  \"Hope Dr. Prado is OK though."),
    replies = {
        {
            text = ccb.content.text("We'll see about the grenades, but I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_2",
    line = ccb.content.text("I want to say… yes?\"  He rubs his chin.  \"Yes.  This is going to be an easy find-and-fetch job and nothing could possibly go wrong.\"  He grins.  \"There, now you have it from the source."),
    replies = {
        {
            text = ccb.content.text("Great, thanks for predicting that.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_3",
    line = ccb.content.text("&He cocks his head at you.  \"My friend, I'm in.  It sounds risky as hell, I'm not letting you go in there alone!  Let's get as geared up as possible though.  Hazard suits.  Heavy armor.  Big guns.  Can I have some EMP grenades?  Please?\""),
    replies = {
        {
            text = ccb.content.text("What is it with you and EMP grenades?  Anyway, I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
