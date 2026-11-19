local ccb = require("ccb")

-- Yeah, that's the basic explanation.  A bit of both now, but I used to be just like you.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot2",
    line = ccb.content.text("Yeah, that be the soggy leaves, an I'm ken.  A bit o' both, but Rubik were once as a kin, to you be."),
    replies = {
        {
            text = ccb.content.text("What are you meaning 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("This is confusing.  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I don't understand a word you're saying."),
            next_topic = "TALK_EXODII_MERCHANT_Dialect",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- A junker base, obviously.  A jury-rigged mess.  We'll pack it up and leave eventually.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Base",
    line = ccb.content.text("A junker base, innit?  Pile o' gamp.  Us'll pack it up and sing along soon enough."),
    replies = {
        {
            text = ccb.content.text("Pack it up?  How can you pack up something like this?"),
            next_topic = "TALK_EXODII_MERCHANT_Base2",
        },
        {
            text = ccb.content.text("Soon?  How long will you still be here?"),
            next_topic = "TALK_EXODII_MERCHANT_BaseTimeLeft",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- The otherlands we were in before had only little time left, so we can't say for sure.  But this land is as fresh as it can be.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_BaseTimeLeft",
    line = ccb.content.text("Yon aforetime otherland, 'twere a right soggy biscuit.  This'n be crisp an' fresh yet.  Us'n'll try as might stay a fair tick."),
    replies = {
        {
            text = ccb.content.text("Good to know you will be here for a while."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
