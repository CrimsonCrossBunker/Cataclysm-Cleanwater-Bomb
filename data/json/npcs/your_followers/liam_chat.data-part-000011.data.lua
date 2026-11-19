local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_SMALL",
    line = ccb.content.text("Well, I like his fashion choices, but he, um.  Well, you know.  You met him.  I don't mind helping him out, in theory, but I don't know if bringing him piles of trash is really going to do anyone any good.  The Merchants might think it's a fire hazard."),
    replies = {
        {
            text = ccb.content.text("Let's try it out anyway.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_DUCT_TAPE",
    line = ccb.content.text("Right, I guess.  I don't quite get why you're doing this stuff for him, he's probably just going to keep piling up the stuff and not doing anything with it.\"  He shrugs.  \"On the other hand, maybe he'll make a kick-ass box fort, I'd be all about that."),
    replies = {
        {
            text = ccb.content.text("That's my hope.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_MEDIUM",
    line = ccb.content.text("I'm telling you, this is just going to go on and on forever.\"  He looks sad.  \"I'd really love to see him get a cool box fort and feel better, but I think we're just enabling his delusions, my friend."),
    replies = {
        {
            text = ccb.content.text("Let's see this through a bit longer.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PLASTIC_SHEET",
    line = ccb.content.text("I gotta admit, this one surprised me.  I take back some of what I said earlier, I'm just confused now.  Let's see where it goes."),
    replies = {
        {
            text = ccb.content.text("Right?  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_LARGE",
    line = ccb.content.text("It had better be!  I'm not sure why you're doing this, but I do think it's good you're trying to help him.  Maybe we should stop eventually though?\"  He sighs.  \"I don't know what to make of Dave.  I worked with a guy with schizophrenia back at Foodplace, and Dave is nothing like that.  I don't know if he's actually got some kind of mental illness or if it's a stress reaction or something.  He doesn't act like any real person I've ever met, and we got all kinds of strung-out types there."),
    replies = {
        {
            text = ccb.content.text("That's good insight.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PERMISSION",
    line = ccb.content.text("Well, I'm definitely interested to see where it goes.  I hope it helps Dave somehow.  I don't know what's going on with him except that it's nothing like any schizophrenia or anything like that I've ever seen, and I've seen practically anything you can imagine, working service."),
    replies = {
        {
            text = ccb.content.text("I have a good feeling.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_1",
    line = ccb.content.text("Well, it probably isn't going to come back alive.  They ooze blood everywhere, when we fight 'em.  It's kinda thicker and goopier than human blood, but I guess not so bad it'd be hard to draw?"),
    replies = {
        {
            text = ccb.content.text("Thanks.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_2",
    line = ccb.content.text("This sounds *nuts* man.  How are we going to get in and out alive?  A place like that is going to be crawling with zombies and who knows what else.\"  He shudders.  \"Let's be careful, right?"),
    replies = {
        {
            text = ccb.content.text("Okay.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_3",
    line = ccb.content.text("This was a total surprise to everyone,\" he grumbles.  \"Still, this can't be any worse than getting the first analysis done, right?"),
    replies = {
        {
            text = ccb.content.text("Let's hope not.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
