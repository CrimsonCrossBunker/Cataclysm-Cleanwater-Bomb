local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro4b",
    line = ccb.content.text(
        --~ That's exactly it!  This is nice for many reasons, and much better than our last jump.  Otherlands with fusillies and mobbings are really useful to us.
        "You kennit rightly!  That and this be'n nice for all, overtop the last jump by heads.  Otherlands with fusillies and mobbings, us'n gets a fine change on that."),
    replies = {
        {
            text = ccb.content.text("I don't know what fusillies and mobbings are."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dictionary_known_fussily" } })),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro5",
        },
        {
            text = ccb.content.text("Wait, am I following this right?  You're from a place where this happened before, and you escaped to our world?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
