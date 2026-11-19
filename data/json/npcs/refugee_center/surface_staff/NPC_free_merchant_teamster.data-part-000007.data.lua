local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader",
    line = ccb.content.gendered_line("Oh yeah, they're my rookie representative.  I figured that those people wouldn't cause too much trouble for them, so I sent them over there.  What about them?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I think they're gouging the prices for the people living there."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Pricegouge",
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
