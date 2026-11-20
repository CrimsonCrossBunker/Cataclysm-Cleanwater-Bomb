local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete3",
    line = ccb.content.text(
        --~ Sure, that word is fine, I think.
        "Sure an' that's a fine enough word, an I'm ken."),
    replies = {
        {
            text = ccb.content.text("You said this was an especially good jump?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_completed_rubik_intro" } })),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3",
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
