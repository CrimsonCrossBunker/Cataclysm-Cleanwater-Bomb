local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_KILL_EVERYBODY",
    line = ccb.content.text("Maybe.  Is it worse to be unhappy with a goal or to be unhappy without a goal?  You're all right, I feel like we get each other."),
    replies = {
        {
            text = ccb.content.text("I feel the same way best friend."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        { text = ccb.content.text("No idea what you mean."), next_topic = "TALK_GLOOSCAP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_JOKING",
    line = ccb.content.text("Haha, right.  What would Glooscap be doing in the sunrise lands at the beginning of the fourth age?  That's silly.  I'm probably some Wabanaki that got hit on the head or something.  And who turns into a beaver?  Haha.  You got me.  Just a normal human made out of trees like the rest."),
    replies = {
        {
            text = ccb.content.text("No problem, a lot of people are going through some hard times right now.  Honestly, you're doing better than most.  You should follow me, I have a pretty good handle on reality."),
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_reality_checked_glooscap", "yes"),
            },
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
        {
            text = ccb.content.text("I'm not made out of trees, I'm made out of awesome.  Follow me and you will grow fat and rich."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_boasted_glooscap", "yes") },
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
        {
            text = ccb.content.text("You shouldn't follow me, but I guess I can't stop you."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_low_esteemed_glooscap", "yes") },
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
    },
}
