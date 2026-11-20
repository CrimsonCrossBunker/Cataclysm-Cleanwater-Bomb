local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro2a",
    line = ccb.content.text(
        --~ As I recall, we were talking about Benzete and how this is a great jump for their first time.
        "So 'twere an I recalt, us're yarkin' of Benzete an' their great first jump."),
    replies = {
        {
            text = ccb.content.text("What makes it such a good jump?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3",
        },
        {
            text = ccb.content.text("Who is Benzete?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
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
