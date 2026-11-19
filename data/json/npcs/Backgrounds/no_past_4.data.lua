local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_NO_PAST_4_SKEPTIC",
    line = ccb.content.text("What?  Of course it does.  They started with a bioweapon and then it went full nuclear.  Only the weapons we had now were a lot worse than H-bombs.  Uncle Sam managed to beat back the really nasty stuff, but I guess it was with his dying breath."),
    replies = {
        {
            text = ccb.content.text("Can you tell me more about what actually went down, though?"),
            next_topic = "CWH_NO_PAST_4_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
