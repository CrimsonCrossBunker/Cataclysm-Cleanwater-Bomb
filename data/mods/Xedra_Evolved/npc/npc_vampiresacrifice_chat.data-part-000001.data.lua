local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_NOT_SACRIFICE",
    line = ccb.content.text("You're a good friend.  I had better friends but I also had way worse."),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Thanks for telling me.  See you later."),
            next_topic = "TALK_DONE",
        },
    },
}
