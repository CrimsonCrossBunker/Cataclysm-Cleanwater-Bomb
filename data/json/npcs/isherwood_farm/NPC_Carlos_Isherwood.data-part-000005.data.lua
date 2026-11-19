local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_BARRY",
    line = ccb.content.text("It was pink and really fast, it had lots of limbs, definitely not human.\"  Carlos rubs the back of his hand idly, staring into space.  \"It easily kept up with us when we tried to escape, horrifying stuff.  Barry just dropped to the ground, and the thing swept him away."),
    replies = {
        {
            text = ccb.content.text("You all just gonna leave him out there to his fate?"),
            next_topic = "TALK_CARLOS_BARRY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_BARRY2",
    line = ccb.content.text("*frowns at you.  \"Of course not.  We tracked it for a while, but lost the trail.  Right now we don't have the resources to try to rescue him.  My son, Chris, has been trying to pick up the trail again and figure out a rescue plan.\""),
    replies = {
        {
            text = ccb.content.text("I could help.  Where did Chris go?"),
            next_topic = "TALK_CARLOS_BARRY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_BARRY3",
    line = ccb.content.text("*shakes his head.  \"Leave Chris be, he knows what he's doing.  Give him some time.  Calling more attention to him could get both of you killed.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_FORGE1",
    line = ccb.content.text("The big item I need is an anvil, once I have that I can get a lot of repairs done.\"  He smiles briefly.  \"Can't exactly head to town to get it done anymore, but I learned a bit of old world metalwork from my granddad."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_FORGE2",
    line = ccb.content.text("*gestures around the workspace, which looks more set up.  \"I'm figuring things out, getting it worked out.  It's been a while since I did this kind of metalwork.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_FORGE3",
    line = ccb.content.text("Yeah, it's coming along nice.\"  He slaps the surface of the anvil.  \"Thanks for this, I'm still getting my skills back up, but it's going to be real helpful."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_CHRIS1",
    line = ccb.content.text("Chris is hiking the perimeter of our land, planning some defense options.\"  He looks you up and down.  \"Best just let him be."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARLOS_CHRIS2",
    line = ccb.content.text("*looks at you curiously.  \"Should be where you saw him last.  He's not missing again, is he?\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CARLOS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
