local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYHO_MAIN",
    line = ccb.content.text("Hey!  Stop right there!  This here is private property!  Not one step closer, you got it?!"),
    replies = {
        {
            text = ccb.content.text("Whoa, calm down, no reason to get heated."),
            next_topic = "TALK_COWBOYHO_2A",
        },
        {
            text = ccb.content.text("You better calm down right now."),
            next_topic = "TALK_COWBOYHO_3A",
        },
        {
            text = ccb.content.text("Does private property even exist anymore?"),
            next_topic = "TALK_COWBOYHO_4A",
        },
        { text = ccb.content.text("Okay, I'm going."), next_topic = "TALK_COWBOYHO_LEAVING" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYHO_LEAVING",
    line = ccb.content.text("Yeah that's right!  And don't bother me again, you hear?!"),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            native_actions = { "end_conversation" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYHO_2A",
    line = ccb.content.text("I said stay away!  Don't get any closer or I swear I will kill you."),
    replies = {
        {
            text = ccb.content.text("Don't threaten me or you will regret it."),
            next_topic = "TALK_COWBOYHO_2B",
        },
        {
            text = ccb.content.text("I really just want to talk - I mean no harm."),
            next_topic = "TALK_COWBOYHO_2B",
        },
        { text = ccb.content.text("Alright, I'm leaving."), next_topic = "TALK_COWBOYHO_LEAVING" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYHO_2B",
    line = ccb.content.text("For the last goddamn time, leave or I will defend myself!  I will kill you!"),
    replies = {
        { text = ccb.content.text("Okay, I'm going."), next_topic = "TALK_COWBOYHO_LEAVING" },
        {
            text = ccb.content.text("I'd like to see you try."),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYHO_3A",
    line = ccb.content.text("Did you just fucking threaten me?!  This is your last chance to piss off or I swear I will end you!"),
    replies = {
        {
            text = ccb.content.text("Alright, alright, I'm going."),
            next_topic = "TALK_COWBOYHO_LEAVING",
        },
        {
            text = ccb.content.text("I'd like to see you try."),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYHO_4A",
    line = ccb.content.text("It does on my property!  Now blow off!"),
    replies = {
        { text = ccb.content.text("Okay, I'll leave."), next_topic = "TALK_COWBOYHO_LEAVING" },
        { text = ccb.content.text("I just want to talk."), next_topic = "TALK_COWBOYHO_2A" },
    },
}
