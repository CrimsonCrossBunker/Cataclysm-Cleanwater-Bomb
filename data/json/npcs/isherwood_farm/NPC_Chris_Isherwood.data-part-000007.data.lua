local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
    line = ccb.content.text("*looks crestfallen for a moment, then straightens up.  \"All right.  Yeah, maybe better not to put them at risk I guess.  So we're back to going in without them.  Maybe that's better, I don't want to lose anyone else.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
