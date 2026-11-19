local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DANA_Sourdough2",
    line = ccb.content.text("Take care of yourself out there.\"  She jots down directions to her bakery and hands them to you.  \"His name is Landough, Landough Calrisean.  He'll be in the right-hand fridge, in a jar with a picture of the Millennium Falcon on it.  And listen, when you bring my sourdough back, I don't want to see a scratch on him, you understand?"),
    replies = {
        { text = ccb.content.text("Right.  Sure."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("All right, old buddy.  You know, I know what he means to you.  I'll take good care of him, so that he won't get a scratch."),
            next_topic = "TALK_DONE",
        },
    },
}
