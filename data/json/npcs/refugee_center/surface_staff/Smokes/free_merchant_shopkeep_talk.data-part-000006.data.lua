local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld", "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld1",
        "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld2",
    },
    line = ccb.content.text("Not as much as I'd like, I'm afraid.  Most of these shelters seemed to have been designed to make people *feel* safer, not to actually keep them safe.  Our radio equipment is terrible… I don't think it was even meant to be used seriously.  I've heard some talk of hordes."),
    replies = {
        {
            text = ccb.content.text("Hordes?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld1",
        },
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } })),
        },
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } }),
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}
