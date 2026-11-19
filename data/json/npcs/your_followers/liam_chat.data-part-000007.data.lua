local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_1",
    line = ccb.content.text("*rubs his chin thoughtfully.  \"Maybe we can set up a bottleneck in the hallway?  First we drag a few lockers or something to funnel them, then one of us hangs close to the barricade and the other stands back and fires arrows or something?\"  He shrugs.  \"I'm not great at tactics, and I'm a bit nervous about what's back there.\""),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2",
    line = ccb.content.text("You sure we haven't bit off more than we can chew here?\"  He stares at you for a moment.  \"This isn't DOTA2, this is real life.  These guys are gonna have guns and shit.  I know we've been through a lot together but if they're ready for us they could take us out before we're even close enough to see them.  I mean, I'm with you if you think we can do it, but be careful, okay?"),
    replies = {
        {
            text = ccb.content.text("Thanks man, I'll keep that in mind.  We gotta do this though.  Any suggestions for how to do it safely?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2-1",
        },
        {
            text = ccb.content.text("Thanks man, I'll keep that in mind.  We'll do this carefully.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2-1",
    line = ccb.content.text("If you're gonna insist on it then I say we drive up quick in the dark, take cover behind the car, and make a ton of noise.  Then we take cover and when they come to check things out, we pick them off.  Or maybe we come in silent, from a distance, and take out their sentries.  A bow is great for that, if we can make the shots.  This whole thing still seems ridiculous though."),
    replies = {
        {
            text = ccb.content.text("Thanks man, I'll keep that in mind.  We'll do this carefully.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_3",
    line = ccb.content.text("I'm kinda looking forward to it.  It's good to see people already building up something to last, after everything that's gone down.  Wonder what we'll find out there."),
    replies = {
        {
            text = ccb.content.text("That's optimistic, thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_4",
    line = ccb.content.text("You know, I read an article about how those stupid FEMA evac shelters all had solar power for emergencies.  I bet nobody's looting those, let's track some down and unbolt 'em."),
    replies = {
        {
            text = ccb.content.text("Not a bad thought.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
