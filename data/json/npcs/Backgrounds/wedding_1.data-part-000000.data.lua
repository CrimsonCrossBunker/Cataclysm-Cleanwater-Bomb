local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY1",
    line = ccb.content.text("Oh, that's quite the story.  <the_cataclysm> happened on my wedding day."),
    replies = {
        { text = ccb.content.text("Oh, I'm sorry…"), next_topic = "BGSS_WEDDING_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY2",
    line = ccb.content.gendered_line("Yeah, in hindsight it maybe wasn't the best choice of dates, huh?  I admit I had cold feet though.  Anyway we were getting hitched at the church.  Lucky for me I was late to the ceremony… I guess some of the fresher corpses in the graveyard had gotten up and started harassing the party.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What did you do next?"), next_topic = "BGSS_WEDDING_1_STORY3" },
        {
            text = ccb.content.text("You seem surprisingly calm about all this."),
            next_topic = "BGSS_WEDDING_1_CALM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY3",
    line = ccb.content.gendered_line("After I saw what was going on, I turned around and headed out in the opposite direction.  I've seen zombie movies before.  I picked up some stuff from home and I managed to get out of town before things went really bad.  At the time I thought I was being a coward, but now I know if I'd stayed to help, I'd just be another dripping corpse.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("You seem surprisingly calm about all this."),
            next_topic = "BGSS_WEDDING_1_CALM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
