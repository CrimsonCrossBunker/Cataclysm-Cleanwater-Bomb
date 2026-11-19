local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY2",
    line = ccb.content.text("Yeah, in hindsight it maybe wasn't the best choice of dates, huh?  I admit I had cold feet though.  Anyway I was running late after partying pretty hard and saw some corpses had gotten up and started harassing the party while they were waiting."),
    replies = {
        { text = ccb.content.text("What did you do next?"), next_topic = "BGSS_WEDDING_1_STORY3" },
        {
            text = ccb.content.text("You seem surprisingly calm about all this."),
            next_topic = "BGSS_WEDDING_1_CALM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY3",
    line = ccb.content.text("After I saw what was going on, I just turned around and headed out in the opposite direction.  I know a bad situation when I see it.  I grabbed a few things and headed out into the woods before things went really bad.  At the time I thought I was being a coward, but now I know if I'd stayed to help, I'd just be another dripping corpse."),
    replies = {
        {
            text = ccb.content.text("You seem surprisingly calm about all this."),
            next_topic = "BGSS_WEDDING_1_CALM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
