local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AskedRestock",
    line = {
        choices = {
            ccb.content.text("Next shipment should arrive in around <restock_time_point>."),
            ccb.content.text("Stick around 'til <restock_time_point>, there will surely be something you'd like."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Thanks, I will make sure to check back.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
