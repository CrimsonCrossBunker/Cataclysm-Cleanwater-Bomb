local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware", "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware1" },
    line = ccb.content.text("Tools, to be precise.  The basement and the storage rooms had way more than we need, and a lot of people brought their own when they were evacuating.  There's more than we could ever use, so we'll be happy to sell them at a very fair price.  Nothing in the way of radios, so you'll have to look somewhere else for that."),
    replies = {
        {
            text = ccb.content.text("Wait, basement?  I didn't know this place had a basement."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_knows_about_basement" } })),
            actions = { actions.set_actor_value("speaker", "general_free_merchants_u_knows_about_basement", "yes") },
        },
        {
            text = ccb.content.text("Mind if I take a look at your stock?"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_5376c19ccc7f") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("Radios?  That seems awfully specific."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware1",
        },
        {
            text = ccb.content.text("Good to know."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}
