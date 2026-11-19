local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY3",
    line = ccb.content.text("She took sick a few hours after we left the lake.  Puking, complaining about her joints hurting.  I took us to some people I knew about on the riverside, hoping they might have something to help or at least know what was going on."),
    replies = {
        {
            text = ccb.content.text("I guess they didn't know."),
            next_topic = "BGSS_OUT_OF_TOWN_2_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY4",
    line = ccb.content.text("The area was empty, actually.  She was desperate though, so I went searching for anything I could grab.  Got my friend a grass blanket and some willow bark, but when I came out to the boat, well… it was too late for her."),
    replies = {
        { text = ccb.content.text("She was dead?"), next_topic = "BGSS_OUT_OF_TOWN_2_STORY5" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
