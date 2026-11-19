local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_BLOODFEED_NOPE",
    line = ccb.content.text("Nope.  I'm not going to be your blood bag.  Find someone else for that."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_BLOODFEED_IMPOSSIBLE",
    line = ccb.content.text("(As you approach to ask about letting you drink their blood, your senses tell you that whatever blood they have in their veins wouldn't nourish you at all, so you decide to not ask your question)"),
    replies = {
        { text = ccb.content.text("(Ask them about something else)"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("(Go do something else)"), next_topic = "TALK_DONE" },
    },
}
