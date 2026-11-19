local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_What",
    line = ccb.content.text("I sure can!  For now, I can make t-shirts, pants, dresses, dusters, trench coats, backpacks, jackets, and a gambeson; if that's your thing."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Time",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Price",
        },
        {
            text = ccb.content.text("Can you make me something else with leather?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_What",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Price",
    line = ccb.content.text("T-shirts, pants, jackets, and dresses are four icons.  Dusters, trench coats, and backpacks are eight icons.  A gambeson is sixteen."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Time",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Time",
    line = ccb.content.text("T-shirts, pants, jackets, and dresses take me just a day.  Dusters, trench coats, and backpacks take four days, while a gambeson takes six days."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Price",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Leather_What",
    line = ccb.content.text("But of course!  Right now, I can make a set of pouches, pants, cloaks, thicker jackets, or even a full set of body armor; it should be useful in your travels."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Something",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Time",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Price",
        },
        {
            text = ccb.content.text("I think I rather want something softer…"),
            next_topic = "TALK_GODCO_Maria_Tailor_What",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Leather_Price",
    line = ccb.content.text("Pouches and pants are eight icons.  Cloaks and thick jackets are twelve icons.  A set of body armor is twenty-four."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Something",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Time",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Leather_Time",
    line = ccb.content.text("Pouches and pants take me two days.  Cloaks and thick jackets take four days, while the set of body armor takes six days."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Something",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Price",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Start",
    line = ccb.content.text("Alright, I'll get to it."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Done",
    line = ccb.content.text("Here it is, I hope you enjoy it.  If you want something else, just come to me."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Angry",
    line = ccb.content.text("'Cause your a <freaking> <name_b> is why!  You think you can just do what fucking ever you want with no consequence!  I'm sick of this, I'm not talking to you anymore."),
    replies = { { text = ccb.content.text("Okay, <name_b>, piss on it."), next_topic = "TALK_DONE" } },
}
