local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_LMOE3",
    line = ccb.content.gendered_line("Nope, that's it.  Got the idea for the door from a book on medieval castles, in case you were wondering.  But instead of a counterweight holding a drawbridge up, I just ram a hex key in a hole.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Interesting…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_LMOE4",
    line = ccb.content.gendered_line("Almost as much as my house, in the end.  I think they realized they could make a lot of money as things got worse and worse.  But it's nicer than my house, too.  They said the ventilation system was built to withstand a month of anything: nuclear fallout, biological attack, you name it.  Concrete and soil above me to absorb radiation, appliances and supplies…  I even brought some old books I've never read.  I always knew it would come to this.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How many of these places did the company build?"),
            next_topic = "BGSS_PREPPER_1_LMOE5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_LMOE5",
    line = ccb.content.text("Dozens, they told me.  Probably more by the end of it.  But they obviously didn't say where or who for.  It was kind of a hot business and I think they were some of the best doing it."),
    replies = { { text = ccb.content.text("Right…"), next_topic = "BGSS_PREPPER_1_LMOE2" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTSUCCESS",
    line = ccb.content.text("Okay, listen… across the hall from the bedroom… by the pillars… it's a fake wall.  Directly across the hall.  If you push in a little bit, the whole thing kinda slides aside.  I hid some guns back there and a handful of rounds, too.  I meant to bring a lot more - I had boxes on back order - but it started getting hard to buy past a certain point.  Might as well share now that we're here.  A spare bullet could save your life."),
    replies = {
        {
            text = ccb.content.text("The wall thing is pretty nifty, I have to admit."),
            next_topic = "BGSS_PREPPER_1_SHARELOOTSUCCESS2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTSUCCESS2",
    line = ccb.content.text("Yeah, but they put the secret room in their advertising.  Not really a secret then, is it?"),
    replies = { { text = ccb.content.text("Hmm, good point."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTFAILURE",
    line = ccb.content.gendered_line("What, like some secret Batcave?  Pull back the curtain and it turns out I'm the communist <name_b> who brewed up a demon bio-weapon in their basement?  I just gave you food, all the tools in my workshop, and the safest hole in the ground in the county.  If I've got any secrets left, they're mine to keep.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("No, you're right!  I'm sorry for intruding!"),
            next_topic = "BGSS_PREPPER_1_SHARELOOTAPOLOGIZE",
        },
        {
            text = ccb.content.text("For all I know, you COULD have something to do with this.  Who really knows what happened?"),
            next_topic = "BGSS_PREPPER_1_SHARELOOTFAILURE2",
            opinion = { anger = 2 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTFAILURE2",
    line = ccb.content.text("Well, I certainly wouldn't tell you.  The way you talk… the questions you ask… they're extremely suspicious.  Why did you ask about the shelter anyway?  What do you want from me?"),
    replies = {
        {
            text = ccb.content.text("I just wanted the loot, I'll be honest."),
            next_topic = "TALK_DONE",
            opinion = { anger = 5, value = -5, trust = -8, fear = -2 },
            native_actions = { "insult_combat" },
        },
        {
            text = ccb.content.text("Well… I'm actually a government agent sent to assassinate you.  I just had to find out the location of your secret stash before I took you out!"),
            next_topic = "BGSS_PREPPER_1_SHARELOOTFAILURE3",
        },
        {
            text = ccb.content.text("I thought we could team up.  It sounded like a good place to stay safe."),
            next_topic = "BGSS_PREPPER_1_SHARELOOTAPOLOGIZE2",
            opinion = { anger = -4 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTFAILURE3",
    line = ccb.content.text("*tenses up and stares in disbelief.  \"You're playing with me.  The government doesn't exist anymore…  You better be messing around or I-\""),
    replies = {
        {
            text = ccb.content.text("Why else would I ask about your shelter?  I don't need your gear.  I don't need your help.  Look around you!  I'm tracking down the last free thinkers who have been putting the puzzle pieces together.  It's YOU I'm after!"),
            next_topic = "BGSS_PREPPER_1_SHARELOOTFAILURE4",
        },
        {
            text = ccb.content.text("Yeah, I'm just messing with you, don't worry.  What, can't take a joke?"),
            next_topic = "BGSS_PREPPER_1_SHARELOOTAPOLOGIZE3",
            opinion = { trust = -3 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTFAILURE4",
    line = ccb.content.gendered_line("I knew it…  This whole time.  It was all part of the plan.  The riots, the storms…  You always had control…", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Prepare to meet your end, <npc_name>.  *Attack <npc_name>.*"),
            next_topic = "TALK_DONE",
            opinion = { anger = 40, value = -30, trust = -30, fear = -10 },
            native_actions = { "hostile", "leave" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTAPOLOGIZE",
    line = ccb.content.text("Yeah, listen, just keep your questions to yourself.  I don't trust you and you shouldn't trust me, either."),
    replies = {
        {
            text = ccb.content.text("Sorry, I won't ask again."),
            next_topic = "TALK_DONE",
            opinion = { anger = -1 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTAPOLOGIZE2",
    line = ccb.content.text("It IS a good place to stay safe.  Just don't go prying, okay?"),
    replies = { { text = ccb.content.text("You got it."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHARELOOTAPOLOGIZE3",
    line = ccb.content.text("You think that's funny?!  Some of us watched the warning signs for years.  All the news, all the violence and the secret plots…  Now the dead are walking, reality itself is tearing apart, and you're making jokes like that?!"),
    replies = {
        {
            text = ccb.content.text("Yeah…?  I didn't realize it bothered you so much."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHELTERSUCCESS",
    line = ccb.content.text("I marked the spot for you.  When you get there, pry off the metal above the door and you'll see the special latch I made to keep thieves out.  I trust you to make the right decisions."),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_SHELTERFAILURE",
    line = ccb.content.gendered_line("I'd have to be absolutely imbecilic to give up the location of my stash to someone I barely know.  For all I know you'd just kill me and take it all for yourself!  Better luck next time, pal.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Okay, calm down…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE1",
    line = ccb.content.text("My… what do you mean?  How would YOU know what the sign says?"),
    replies = {
        {
            text = ccb.content.text("I uh… found my way inside it a while ago.  The door was already open.  I kinda went through it already assuming whoever owned it was dead."),
            trial = { kind = "lie", difficulty = 20, modifiers = { { score = "TRUST", scale = 2 } } },
            success = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE2_BENICE" },
            failure = { next_topic = "BGSS_PREPPER_1_FOUND_LMOE2_FAILLIE" },
        },
        {
            text = ccb.content.text("So it WAS yours?  I broke in and stole a bunch of stuff from it.  Sorry, I guess."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE2_BEMEAN",
            opinion = { trust = -1 },
        },
        {
            text = ccb.content.text("Well, I got inside one and found a computer with a bunch of… conspiracy theory documents?  I'm not sure how to put it.  It seemed like whoever wrote it wasn't doing well."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE5",
            opinion = { trust = -2 },
        },
    },
}
