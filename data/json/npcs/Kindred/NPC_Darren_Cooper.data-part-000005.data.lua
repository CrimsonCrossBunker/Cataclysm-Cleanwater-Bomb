local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_NOTFMLR",
    line = ccb.content.text("Brigitte did not mention me?  I'm surprised.  Perhaps she's starting to understand I was right.  I was with her for a time, learned from her.  I'm still on her side, but she doesn't realize it yet."),
    replies = {
        {
            text = ccb.content.text("You know Brigitte?  What happened with you two?"),
            next_topic = "TALK_COOPERS_SIDE",
        },
    },
}
