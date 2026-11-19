local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_NO_PAST_5_STORY1",
    line = ccb.content.gendered_line("Let's not talk about it, ok?  It just hurts to think about.  I've lost so many people… and I'm sure you have too.  Let's focus on the here and now.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I can respect that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Fair enough.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}
