local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_2",
    line = ccb.content.text("Things suck right now, but you know that anyway.  I don't even know why you bother asking these stupid questions."),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_GODCO_chloe_past" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_help",
    line = ccb.content.text("I'm not a baby you know, I don't need a babysitter.  Sonia looks out for me though.  She's not so weird, I guess.  She promised to give me guitar lessons and she even signed me an autograph.  I know she's only nice to me because I saved her, but that's okay; we're equal now."),
    replies = {
        {
            text = ccb.content.text("How'd you and Sonia come to meet?"),
            next_topic = "TALK_GODCO_chloe_sonia",
        },
        { text = ccb.content.text("Yeah, that's enough for me."), next_topic = "TALK_DONE" },
    },
}
