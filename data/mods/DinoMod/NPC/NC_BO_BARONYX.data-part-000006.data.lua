local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REJECTED_SWAMPER",
    line = ccb.content.text("Of course, the company will be ready when you are and the great eaters will feed either way."),
    replies = {
        {
            text = ccb.content.text("Maybe some other time.  Changing the topic…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Alright, but I have to go now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_PRETENDER",
    line = ccb.content.text("It was foretold that as the great eaters returned, so too would the pretenders, who would come to steal the meat.  Very little is asked of us, except that we do all we can to ensure that the true great eaters received as much meat as possible and the pretenders go hungry."),
    replies = {
        {
            text = ccb.content.text("Yes CEO Baronyx, very good CEO Baronyx."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("This makes no sense and I'm done talking about it."),
            next_topic = "TALK_DONE",
        },
    },
}
