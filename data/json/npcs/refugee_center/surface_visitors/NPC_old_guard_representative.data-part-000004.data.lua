local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_EXODII_2",
    line = ccb.content.text("Well, that's interesting.  It's not something I'm in a position to do something about, but you might want to take that information to one of the teamsters for the Free Merchants.  Maybe that's a way we could establish some friendlier relationships."),
    replies = {
        { text = ccb.content.text("Good idea.  I'll go do that."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Huh, maybe.  <done_conversation_section>"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}
