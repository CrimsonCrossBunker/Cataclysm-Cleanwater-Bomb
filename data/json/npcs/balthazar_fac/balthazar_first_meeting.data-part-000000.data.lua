local ccb = require("ccb")

-- Balthazar is not in a good position right now and will try to make people help them out of pity
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_WEAK",
    line = ccb.content.text("I'm Balthazar and have been stuck in this bunker ever since the sky ruptured!  I don't really know what's happening out there and need someone to help me.  The power to the bunker has been running low and the air & water filtration are failing intermittently."),
    replies = {
        {
            text = ccb.content.text("What do you need help with?"),
            next_topic = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
        },
        {
            text = ccb.content.text("What's in it for me?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_WEAK",
        },
        {
            text = ccb.content.text("Why don't these robots attack me?"),
            next_topic = "TALK_BALTHAZAR_MEET_ROBOT_WEAK",
        },
        {
            text = ccb.content.text("Hold on, why are you locked in here?"),
            next_topic = "TALK_BALTHAZAR_MEET_BUNKER_WEAK",
        },
        {
            text = ccb.content.text("So who are you?"),
            next_topic = "TALK_BALTHAZAR_MEET_BALTHAZAR_WEAK",
        },
        { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" },
    },
}
