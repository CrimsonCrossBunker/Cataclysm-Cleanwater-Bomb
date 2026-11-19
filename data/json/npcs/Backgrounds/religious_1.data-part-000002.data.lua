local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_FAITH1",
    line = ccb.content.text("What?  How could you say something like that?  I can't believe you'd look at all this and think it could be anything but the end-times.  The dead are walking, the gates of Hell itself have opened, the Beasts of the Devil walk the Earth, and the Righteous have all be drawn up into the Lord's Kingdom.  What more proof could you possibly ask for?"),
    replies = {
        {
            text = ccb.content.text("What will you do, then?"),
            next_topic = "BGSS_RELIGIOUS_1_FAITH2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
