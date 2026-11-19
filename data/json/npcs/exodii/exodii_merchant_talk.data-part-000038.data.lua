local ccb = require("ccb")

-- If you want to try it, I won't stop you.  In fact, I'll sell you equipment that might help.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline3",
    line = ccb.content.text("If ye be champed t'try, this'n won't stop ye.  Right so, Rubik'll sell ye the pieces ye might use t'do."),
    replies = {
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
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
