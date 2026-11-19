local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RELIGIOUS_1_STORY1",
    line = ccb.content.text("My story.  Huh.  It's nothing special.  I had people, but they've risen to be with the Lord.  I don't understand why He didn't take me too, but I suppose it'll all be clear in time."),
    replies = {
        {
            text = ccb.content.text("Do you mean in a religious sense, or…?"),
            next_topic = "BGSS_RELIGIOUS_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
