local ccb = require("ccb")

-- This is what you'd call a 'starter package', if I understand it.  Suitable to get you started, but for the really sweet parts you're going to want what I'm selling.  As we get to know each other better, I'll be able to get access to even more stuff.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodized2",
    line = ccb.content.text("This're what ye'd razz a 'starter package', an I'm ken.  Tassed to get ye started, but for the real lemony tarts you'd be wantin' what this'n's got for sale.  As us'n can come to see you clairly-like, this'n can be tassed to offer more an' more."),
    replies = {
        {
            text = ccb.content.text("So you can sell me more bionics, and as I get to know you better you'll have more?  Mind showing me what you've got right now?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_EXODII_MERCHANT_DoneTrade",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
