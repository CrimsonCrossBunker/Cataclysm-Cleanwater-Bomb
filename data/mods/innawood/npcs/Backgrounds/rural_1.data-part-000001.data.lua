local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY2",
    line = ccb.content.text("Well, it built up a bit.  There was that acid rain, it burnt up my crops.  Not that I'd been working the fields since… well, it'd been a terrible year and I hadn't done much worth doing.  There were explosions and things, and some strange sounds.  I was scared, kept to my shelter, practicing on my flute.  Then, one day, it was quiet."),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
