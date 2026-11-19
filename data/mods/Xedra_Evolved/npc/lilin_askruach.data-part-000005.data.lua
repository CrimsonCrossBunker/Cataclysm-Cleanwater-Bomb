local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_NOPE",
    line = ccb.content.text("Nope.  I'm not giving you any of mine.  Find someone else if you want some."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_IMPOSSIBLE",
    line = ccb.content.text("(you sense that you won't be able to drain this person's ruach, so you decide to not ask your question)"),
    replies = {
        { text = ccb.content.text("(Ask them about something else)"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("(Go do something else)"), next_topic = "TALK_DONE" },
    },
}

-- separate dialogue to include a more explicit message about why the follower cannot be drained.
ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_OWL_FORM",
    line = ccb.content.text("(you sense that you won't be able to drain this person's ruach while you are maintaining your owl transformation, so you decide to not ask your question)"),
    replies = {
        { text = ccb.content.text("(Ask them about something else)"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("(Go do something else)"), next_topic = "TALK_DONE" },
    },
}
