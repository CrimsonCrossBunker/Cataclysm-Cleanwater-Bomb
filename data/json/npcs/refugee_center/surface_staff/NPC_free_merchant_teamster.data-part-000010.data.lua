local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Pricegouge",
    line = ccb.content.text("Is that so?  What makes you think that?  My accounting reports have come back clean, just like everybody else."),
    replies = {
        {
            text = ccb.content.text("Everything they sell I can buy for twice as less here, even a box of crackers is an arm and a leg."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Investigation_Mission",
        },
        {
            text = ccb.content.text("I guess you guys are a bunch of thieves if you charge that much."),
            next_topic = "TALK_DONE",
            opinion = { anger = 2 },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
