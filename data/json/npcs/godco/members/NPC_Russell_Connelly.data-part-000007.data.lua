local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Joinee",
    line = ccb.content.text("And I hate to break it to you, but my point still stands."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm humbled by your words.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
