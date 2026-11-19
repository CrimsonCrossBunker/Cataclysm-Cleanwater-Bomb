local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF",
    line = ccb.content.gendered_line("Hey, I didn't expect to live long enough to see another living human!", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_INTRO",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_INTRO",
    line = ccb.content.gendered_line("I've been here since shit went down.  Just my luck I had to work.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_LEAVE",
        },
        {
            text = ccb.content.text("How are you alive?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_STORY1",
        },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_LEAVE",
    line = ccb.content.gendered_line("Well, the dishwasher made a break for it three days after things got weird.  He was ripped to shreds before he made it to the street.  I figure this place has gotta be safer than my apartment, and at least I've got all this food here.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_STORY1",
    line = ccb.content.gendered_line("I… um… hid.  I was in the kitchen, preparing another masterpiece when I heard glass shattering followed by screaming.  I ran over to the serving window to see what happened, assuming a guest had fallen and broke something.  What I witnessed was the most awful thing I've ever seen.  I'm not even sure I could go over it again.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened next?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_STORY2",
        },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_STORY2",
    line = ccb.content.gendered_line("Some lunatic covered in a film of goo, black as oil, had fallen through one of the large glass windows.  There were glass shards stuck in its head and neck.  I thought the poor guy, girl-thing-whatever was dead.  People began to crowd around it, some were taking pictures.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Horrible.  Did you get any pictures yourself?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_STORY3",
        },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_STORY3",
    line = ccb.content.gendered_line("No!  I figured the thing dead until it started writhing and spazzing out for a moment.  Everyone jumped back, a few screamed, and one curious stranger stepped in closer, kneeling a little… it attacked him!", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What'd you do?"), next_topic = "TALK_NC_SURVIVOR_CHEF_STORY4" },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_STORY4",
    line = ccb.content.gendered_line("I ran to the back of the kitchen and hid as best I could.  People outside were screaming and I could hear them running.  Suddenly I heard more glass shatter and something skitter out of the restaurant.  I waited a moment and then went and checked the dining area.  Both the stranger and the thing were gone.  People were running in the streets, some even had guns so I locked all the doors and blocked the windows with what I could and barricaded myself in here.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Crazy, so you have been here ever since?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_STORY5",
        },
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_STORY5",
    line = ccb.content.gendered_line("Yeah, it was awhile before it was quiet again.  I heard all kinds of sounds: explosions, jets flying by, helicopters, screaming, and rapid gunfire.  I swear I even heard what sounded like a freaking tank drive by at one time!  I've been hiding here since.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What did you do before the Cataclysm?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_EXPERTISE",
    line = ccb.content.gendered_line("I've been a cook since forever, this wasn't the best joint, but management was cool.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_LEAVE",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
