local ccb = require("ccb")

-- Haha, not mostly, mate.  It's not worth risking the side effects, you see?  I keep the parts of me that make me Rubik, but the rest is all solid.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival2",
    line = ccb.content.text("Haha, not mostly, mate.  Not worth riskin' the willies, innit?  I keep what's Rubik, but the rest is all solid."),
    replies = {
        {
            text = ccb.content.text("What?  I mean, really, it seems like you're being hard to understand on purpose.  What are the 'willies'?"),
            next_topic = "TALK_EXODII_MERCHANT_Survival3",
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

-- Oh, sure, that's a fair assessment.  I mean, I do get a bit of a laugh out of the look on your face sometimes.  What I'm saying is, if my body were flesh and bone, the device we use to travel around dimensions would rip up the meat and leave me quite a mess.  We can take a bit, but too much… one time, I felt a bit of that, and I'm not in any rush to try it again.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival3",
    line = ccb.content.text("Oh, sure an it's bagged in a coffer an' all that.  That is t'say, this'n does get a wipe o' a grinny t'see the perplexion upon a visage, an I'm ken.*  You're pretty sure you hear a faint chuckle in the metallic voice.  *What I be meanin' is at, for my body were t'be meat-an'-bone, the tool what we be usin' for t'travel to an' fro, it rips up the meat an' leaves it a right mess.  A bit can come along for a right fun, but too much… on a time, an earlier Rubik felt a spot o' those willies, an' this'n be not in the farrier's hut for t'try it again."),
    replies = {
        {
            text = ccb.content.text("What?  I mean, really, it seems like you're being hard to understand on purpose."),
            next_topic = "TALK_EXODII_MERCHANT_Survival3",
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
