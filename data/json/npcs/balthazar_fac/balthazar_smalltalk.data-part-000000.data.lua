local ccb = require("ccb")

-- This never happened, Balthazar took advantage of the confusion that the Cataclysm brought and shot the guards in its lucidity.
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SELF_WEAK",
    line = ccb.content.text("When the riots were getting bad, we were assigned to hold this bunker for some eggheads.  Then when the skies broke some of my comrades just started shooting all around, so I fled into this bunker.  Something messed with the doors and I've been locked in here since."),
    replies = {
        {
            text = ccb.content.text("That sounds rough."),
            next_topic = "TALK_BALTHAZAR_SELF_WEAK_FOLLOWUP",
        },
        {
            text = ccb.content.text("So who are you?"),
            next_topic = "TALK_BALTHAZAR_SELF_STORY_WEAK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SELF_WEAK_FOLLOWUP",
    line = ccb.content.text("Just gotta keep my head down and focus on the now."),
    replies = { { text = ccb.content.text("Good luck."), next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN" } },
}

-- Balthazar is, as usual, lying through their teeth
ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_SELF_STORY_WEAK",
    line = ccb.content.text("I'm a combat engineer who got sent here to hold this bunker.  I guess I'm still accomplishing that, huh."),
    replies = {
        { text = ccb.content.text("I guess so."), next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN" },
        {
            text = ccb.content.text("How come you're locked up?"),
            next_topic = "TALK_BALTHAZAR_SELF_WEAK",
        },
    },
}
