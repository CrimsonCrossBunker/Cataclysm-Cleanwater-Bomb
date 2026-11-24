local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

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

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_ROBOTS_WEAK",
    line = ccb.content.text("This bunker has a control center for the local bots so I made them only attack when attacked first."),
    on_enter = {
        { once = "knows_control_center", actions = { actions.handler("dlg_a_dda_219009214fa4") } },
    },
    replies = {
        {
            text = ccb.content.text("Sounds useful."),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_ROBOTS_STRONG",
    line = ccb.content.text("I got a control center.  Anything else or will you hear me out now?"),
    on_enter = {
        { once = "knows_control_center", actions = { actions.handler("dlg_a_dda_219009214fa4") } },
    },
    replies = {
        {
            text = ccb.content.text("Fine, what do you need help with?"),
            next_topic = "TALK_BALTHAZAR_MEET_STRONG",
        },
        {
            text = ccb.content.text("There was something else…"),
            next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN",
        },
    },
}
