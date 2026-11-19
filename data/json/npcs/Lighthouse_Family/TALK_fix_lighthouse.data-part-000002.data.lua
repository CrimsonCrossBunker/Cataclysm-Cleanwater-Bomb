local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ENG_LIGHTHOUSE_1",
    line = ccb.content.text("Sure thing, boss.  Take me there and in a few days it will be like new."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_DONE",
        },
    },
}
