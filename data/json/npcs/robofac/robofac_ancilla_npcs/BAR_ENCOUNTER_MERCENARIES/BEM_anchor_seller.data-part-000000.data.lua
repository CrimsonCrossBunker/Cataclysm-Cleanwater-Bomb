local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "BEM_ANCHOR_SELLER_1", "BEM_ANCHOR_SELLER_ASK" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } }),
        yes = ccb.content.gendered_line("Sorry I'd rather be left alone right now.", { "interlocutor" }),
        no = ccb.content.gendered_line("&A grim expression and deep sunken eyes imply some malady that can't be simply drowned with alcohol alone.  They interrupt you just as you were about to introduce yourself.  \"This anchor I'm wearing, I don't think I'll be needing it any more.  I-I'm just looking for someone to rid me of it.\"", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Offer to buy the anchor for 1 HGC."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } })),
            next_topic = "BEM_ANCHOR_SELLER_2",
        },
        {
            text = ccb.content.text("Well, what's that thing for anyways?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } })),
            next_topic = "BEM_ANCHOR_SELLER_ASK",
        },
        {
            text = ccb.content.text("Sorry, I don't think I can help you."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } })),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Alright, see you around then."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } }),
            next_topic = "TALK_DONE",
        },
    },
}
