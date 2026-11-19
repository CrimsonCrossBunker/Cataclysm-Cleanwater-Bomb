local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Beggars_Reward",
    line = ccb.content.text("We don't have a lot to share, but… well, I guess it's not safe for them.  At best, it's a health hazard waiting to happen.  We could pay you in merch if you can clear them out without anyone getting hurt, yeah."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do.  What's merch?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMerch",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_knows_about_merch" } })),
        },
        {
            text = ccb.content.text("No guarantees, but I'll see what I can do."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}
