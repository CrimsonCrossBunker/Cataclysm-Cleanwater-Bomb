local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_DRACO_FAE",
    line = ccb.content.text("What does this story remind me of?  Is it, Rip van Winkle?  Didn't he join some party and come home a dozen years later?"),
    replies = {
        {
            text = ccb.content.text("Maybe we should avoid drinking anything there?"),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BRING_BOANN_JABBERWOCK_HEART",
    line = ccb.content.text("Is Lewis Carrol hiding behind a bush over there?  Because if not, this sounds insane and insanely dangerous.  But no one else has even given us a hint about a way off this world of the dead.  Can we really pass this by?"),
    replies = {
        {
            text = ccb.content.text("It's you and me buddy, to infinity and beyond!"),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
