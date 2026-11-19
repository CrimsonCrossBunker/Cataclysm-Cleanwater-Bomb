local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_TroubleWithFood",
    line = ccb.content.text("Yes we are.  The center had a good stock of those awful soy bars, but between all of us, it went fast.  We're making do with what we can skim off the edge of towns, but mostly we rely on trade from people like you.  Speaking of, we'll pay top dollar for anything preserved - canned, salted, dried, whatever.  Just talk to the broker in the back."),
    replies = {
        {
            text = ccb.content.text("I don't see that many of you around."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_knows_about_basement" } })),
            actions = {
                actions.set_actor_value("speaker", "general_free_merchants_u_knows_about_basement", "yes"),
            },
        },
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}
