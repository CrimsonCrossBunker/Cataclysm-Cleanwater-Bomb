local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh3",
    line = ccb.content.text("*shudders, looking like he might vomit.  \"What did they want?  Why me?  Every time, they'd put me back together again, seal it up and make it look almost like nothing happened.\"  He yanks up his shirt to show the scars.  \"But I know what happened, it was REAL, goddammit!\"  He drops the shirt, bends forward, and dry heaves for a few seconds.  Wordless, he hides his face in his hands, and stops responding."),
    replies = { { text = ccb.content.text("[Leave.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_fresh_stop",
    line = ccb.content.text("Yeah.  Yeah.\"  He takes a long, shaky breath.  \"Yeah, you're right.  This isn't going anywhere good.  Claire's been talking about making some dandelion wine,\" he says with a hollow smile.  \"Maybe I'll go see if she needs help."),
    replies = {
        {
            text = ccb.content.text("How about we change the subject instead?  What's your role in this family?"),
            next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family1",
        },
        { text = ccb.content.text("Good idea."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_TOWER_family1",
    line = ccb.content.text("&He wipes his hand across his face, tension leaving him as he runs his fingers through his hair.  \"Yeah, okay.  To be honest, years ago I was the black sheep.  Moved off the family farm, lived out in Bunyan.  Went to college, thought I'd get a job in computers.\"  He shuffles in his chair, smiling half-heartedly.  \"I did sysadmin stuff for a while, back when the internet was fairly new.  Then my dad died.  Carlos and Jesse had just gotten married, and at the time it looked like they might be getting some land of their own, and Eddie was out finding himself.  My dad and I had never got along, but Jack…\" he stops.  \"Sorry, I don't think you were looking for my life story.  What did you ask, again?\""),
    replies = {
        { text = ccb.content.text("No, go on."), next_topic = "TALK_ISHERWOOD_BARRY_TOWER_family2" },
        {
            text = ccb.content.text("You're right.  I was asking something different."),
            next_topic = "TALK_ISHERWOOD_BARRY_askback",
        },
        { text = ccb.content.text("It's okay, I'm going to head out."), next_topic = "TALK_DONE" },
    },
}
