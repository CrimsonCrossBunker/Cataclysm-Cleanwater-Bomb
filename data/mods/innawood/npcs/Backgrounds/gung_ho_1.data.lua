local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GUNG_HO_1_STORY2",
    line = ccb.content.text("Almost got killed.  One <zombie> is easy pickins, but ten is a lot, and a hundred is a death trap.  I got myself in too deep, an' barely slipped out with my guts still inside me.  Holed up in a cave for a while lickin' my wounds and thinkin' about what I wanted to do next.  That's when I figured it out."),
    replies = {
        { text = ccb.content.text("Figured what out?"), next_topic = "BGSS_GUNG_HO_1_STORY3" },
        {
            text = ccb.content.text("Never mind.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text("Never mind.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}
