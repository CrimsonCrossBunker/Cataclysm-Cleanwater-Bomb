local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_COP_3_STORY3",
    line = ccb.content.text("Honestly, probably better than it sounds.  I had a nice tent, a lot of good stuff.  I hadn't suffered any internal organ damage and I'd already had some good time to recover.  I think it kept me from doing anything too stupid, and believe me there was a high chance of that.  For a long time I had these Rambo visions of rushing in and saving everyone, but I was still too immobile.  By the time I had my strength back, it wasn't an option… it was too late.  The closest I got to saving any old friends was putting down the monsters wearing their faces."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
