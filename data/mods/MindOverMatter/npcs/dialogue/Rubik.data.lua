local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_Post_Scan" },
    line = ccb.content.text("&Rubik is looking at you oddly.  The silence is palpable."),
    replies = {
        {
            text = ccb.content.text("Sorry, I must have zoned out for a moment there.  It's been a long day.  You were saying?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}
