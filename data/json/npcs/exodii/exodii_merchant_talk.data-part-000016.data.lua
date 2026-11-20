local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro3a",
    line = ccb.content.text(
        --~ No worries.  I mean, the Enemy is new here, and we have a bit of safe time ahead of us before we have to jump away again.
        "Neverken.  Right and so, the Enemy is new here, and us'n have a few good hours in the sun beforenext the jump."),
    replies = {
        {
            text = ccb.content.text("Oh, you mean you got here early in the Cataclysm.  Why is that so good?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro4a",
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
