local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
    line = ccb.content.text("Well, that's a lot to take in.  What do they want?"),
    replies = {
        {
            text = ccb.content.text("[Boot up the Exodii TV-radio] Maybe it's best if their representative does the talking.  We'll call them on this screen.  They sort of speak English, and I can try and translate back and forth."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations",
        },
    },
}
