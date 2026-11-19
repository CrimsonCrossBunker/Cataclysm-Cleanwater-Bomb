local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = {
        "TALK_ROBOFAC_MERC_1_ASK_HUB",
        "TALK_ROBOFAC_MERC_1_ASK_HUB_DOCS",
        "TALK_ROBOFAC_MERC_1_ASK_HUB_NETWORK",
    },
    line = ccb.content.text("Not a whole lot, really.  They made me track down and destroy some government documents a while back.  Obviously I read them first, but it wasn't much.  As far as I know, this place had an experimental computer network before everything went to hell.  What's going on in there now is anybody's guess."),
    replies = {
        {
            text = ccb.content.text("Hold on, government documents?"),
            next_topic = "TALK_ROBOFAC_MERC_1_ASK_HUB_DOCS",
        },
        {
            text = ccb.content.text("Computer network?"),
            next_topic = "TALK_ROBOFAC_MERC_1_ASK_HUB_NETWORK",
        },
        { text = ccb.content.text("Strange bedfellows…"), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_ASK_HUB_DOCS",
    line = ccb.content.text("Yeah!  Crazy shit.  They sent me to an office building to find a folder with a certain serial and get rid of it.  They didn't even care what was on it.  By the time I got there, though, the building was pretty much a wreck.  The folder had been sitting in a puddle for God knows how long, and there was nothing even remotely legible by then."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_ASK_HUB_NETWORK",
    line = ccb.content.text("That's what the news said, anyway.  It was only about a 20-minute trip from my apartment and sometimes I'd drive past it, so I was curious and I did some research into it.  The only info I could find about it online said that it was a NASA lab for computer research, but that was probably bullshit.  I mean, do you see any NASA logos?  Sure, we got huge steel doors and 15-foot concrete walls, but not a logo in sight.  The building probably goes underground, right?  It's way too small to be a whole laboratory up here."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_GOING_ON", "TALK_ROBOFAC_MERC_1_GOING_ON_SLEEP" },
    line = ccb.content.text("Just trying to get some rest.  I don't have anywhere else to stay, so they let me sleep on the couch out here as long as I keep my gun handy."),
    replies = {
        {
            text = ccb.content.text("They don't let you in to sleep?"),
            next_topic = "TALK_ROBOFAC_MERC_1_GOING_ON_SLEEP",
        },
        { text = ccb.content.text("Fair enough."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GOING_ON_SLEEP",
    line = ccb.content.text("Dude, I wish.  It sounds like there's different people on the mic at different times, but all of them give me the same spiel: nobody's allowed in right now.  I guess I shouldn't raise a fuss about it, honestly.  All being considered, this compound is pretty safe, and the couch ain't so bad."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_COINS",
    line = ccb.content.gendered_line("Yeah.  Have you noticed how they pay us in these tiny little gold coins?\"  Cranberry holds one up for emphasis.  \"It's bizarre.  You'd think they have a gold mine in there, but no, they don't, so they make me cross the damn world grabbing gold bars.  As far as scrip goes, it seems inconvenient as hell to make.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("You sound frustrated about it."),
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION",
        },
        {
            text = ccb.content.text("Now that you mention it, it does seem rather strange."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_RANDOM_THOUGHTS",
    line = {
        choices = {
            ccb.content.text("Thinking I should go hunt something soon…"),
            ccb.content.text("Just wondering if things will get better someday."),
            ccb.content.text("Hmm?  Nothing, I guess I just like resting in this place.  I feel good today."),
            ccb.content.gendered_line("Have you ever noticed how… wait no, never mind.", { "speaker" }),
            ccb.content.text("Wondering if the whole world is like this now.  It has to be, right?  I was watching some foreign news channels when everything was going down, and it sounded like things were just as bad there…"),
            ccb.content.gendered_line("Hey, did you notice that there's working wi-fi here?  Not that anything else is online anymore, but still.", { "speaker" }),
            ccb.content.text("Just vibing."),
        },
    },
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP",
    line = ccb.content.text("*picks the gun up and shows it to you from a few different angles.  You've never seen anything like it; it has a steel body with composite blue furniture, and looks lightweight and cutting-edge.  It features a modern hybrid scope, built-in attachments, and a strange quick-release button on the side.  The magazine looks like something for an assault rifle, but the magazine well itself is strangely designed and seems to be fitted with an adapter to make the magazine actually fit.\n\n\"Whatcha think?\""),
    replies = {
        {
            text = ccb.content.text("Is that a custom Hub rifle?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
        },
        {
            text = ccb.content.text("Where'd you find that thing?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
        },
        {
            text = ccb.content.text("Sweet piece of salvage."),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
        },
    },
}
