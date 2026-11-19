local ccb = require("ccb")

-- They're an otherlander from around three jumps ago, a real optimistic greenhorn.  They're really interested in how we do tracking, you see?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
    line = ccb.content.text("Them's an otherlander from thrice jumps an' change, wide as the sky.  They's got happily on sommat for the tracking, you ken?"),
    replies = {
        {
            text = ccb.content.text("I… didn't really follow that."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete2",
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

-- Like an apprentice to the old tracker.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete2",
    line = ccb.content.text("Hmm.  They… planned out the last jump?  Like as an apprentice to the ol' sexten."),
    replies = {
        {
            text = ccb.content.text("Oh, like a navigator?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_IntroBenzete3",
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
