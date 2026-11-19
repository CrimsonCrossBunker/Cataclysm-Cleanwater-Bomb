local ccb = require("ccb")

-- This is placeholder for now, actual mission to be implemented later
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SELF_STRONG",
    line = ccb.content.text("Something forced me to hide in here.  Will you help me now?"),
    replies = {
        {
            text = ccb.content.text("Fine, what do you need help with?"),
            next_topic = "TALK_BALTHAZAR_MEET_STRONG",
        },
        {
            text = ccb.content.text("Not until I know who you are."),
            next_topic = "TALK_BALTHAZAR_SELF_STORY_STRONG",
        },
        {
            text = ccb.content.text("I wanted to know something else first…"),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}

-- Balthazar is, as usual, lying through their teeth
-- This is placeholder for now, actual mission to be implemented later
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SELF_STORY_STRONG",
    line = ccb.content.text("I'm a combat engineer who got sent here to hold this bunker.  Can we get down to business now?"),
    replies = {
        {
            text = ccb.content.text("Fine, what do you need help with?"),
            next_topic = "TALK_BALTHAZAR_MEET_STRONG",
        },
        {
            text = ccb.content.text("I wanted to know something else first…"),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}
