local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
    line = ccb.content.text("*shrugs.  \"Did you need something else?\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cruel",
    line = ccb.content.text("*bristles.  \"I know, alright?  I do.  I hate it too.  But we are packed to the gills right now, and the only way we're going to stay alive is if we keep our gates closed fast.  I don't know what made the scavengers out there so ruthless, but some of us have had to kill our own kids.  Please show some consideration.\""),
    replies = {
        {
            text = ccb.content.text("I'm sorry."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal",
    line = ccb.content.text("We are.  That's why we're turning people away."),
    replies = {
        {
            text = ccb.content.text("I'm saying you're giving up a potential source of meat."),
            success = {
                opinion = { trust = -5, fear = -2, value = -1, anger = 1 },
                next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal2",
            },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  Don't know where I was going with that."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal2",
    line = ccb.content.text("I can't tell if you're joking or not, but that is seriously fucked up, and I don't want to hear another word about it.  Okay?"),
    replies = {
        {
            text = ccb.content.text("Alright, alright, I'm sorry.  Bad joke."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
        { text = ccb.content.text("Your loss."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_AboutMe", "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Basic",
        "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes2",
    },
    line = ccb.content.text("Not much to say.  What did you want to hear?"),
    replies = {
        {
            text = ccb.content.text("How'd you end up here?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Basic",
        },
        {
            text = ccb.content.text("Smokes?  That's quite a name."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes",
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Basic",
    line = ccb.content.text("Well, I'm Gavin, like I said.  I was a fireman before <the_cataclysm>, and I was also on duty when everything fell apart.  I'd rather not go into detail, but other than that, I wasn't really much to write home about.  My family was Irish, I never married, and I liked woodworking.  I volunteered to take inventory of what the center had when I got off the bus, one thing leads to another, and now I'm here."),
}
