local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_DELIVERY_WEAK",
    line = ccb.content.text("I can remotely control a few of the maintenance bots.  All I need you to do is drop them off at the intercom I've managed to set up and I'll get to work installing them."),
    replies = { { text = ccb.content.text("Got it."), next_topic = "TALK_DONE" } },
}

-- Balthazar is not in a good position right now and will act feeble to try and underpay people
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_WEAK",
    line = ccb.content.text("I don't have much.  All I have in here is some MREs, bullets and a few guns so I'll let you take your pick when you bring some panels."),
    replies = {
        {
            text = ccb.content.text("You're locked in there, right?  How would I get them?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_EXCUSE_WEAK",
        },
        {
            text = ccb.content.text("That doesn't sound too promising…"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_1",
        },
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK_1",
        },
    },
}

-- Balthazar will lie so as to not reveal that they are an AI
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_EXCUSE_WEAK",
    line = ccb.content.text("The airlock is the only part that is malfunctioning, luckily it's connected to the ventilation systems so I made a bot that can traverse them."),
    replies = {
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
    },
}
