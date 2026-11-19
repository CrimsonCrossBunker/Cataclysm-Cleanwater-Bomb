local ccb = require("ccb")

-- Yeah, that's a big question.  Otherworlds are how you got those ugly bug-creatures around here, you know?  Walking plants, talking mushroom, stuff like that.  Otherlands are closer related.  I'm from Earth, just a different Earth.  You shouldn't be asking what the Exodii are doing in Earth, because some of us are feeling pretty at home here, I think.  You should be asking what we're doing hanging out in your part of town.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Aliens2",
    line = ccb.content.text("Sure an that's a biggun'.  Otherworlds be the wherefore o' them uggo buggers you got round and here, eh?  Walkin' plants and talkin' mushrooms and whatlike.  Otherlands be tassed more of a kinship.  I be from Earth, but my Earth be differed.  So you's shouldno be asked what the Exodii is doin' on Earth, because some is feelin' of us fine an' fine at home, an I'm ken.  You's should be askin' what the Exodii is doin' razzin up your green and brown."),
    replies = {
        {
            text = ccb.content.text("OK then, what are you meaning with 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("Tell me about your own world."),
            next_topic = "TALK_EXODII_MERCHANT_Home",
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

-- Ah.  Home.  That's a long time gone, you know?  Yours isn't too different.  I… don't think I want to talk about it.  I've changed too much between then and now.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Home",
    line = ccb.content.text("*becomes distant for a moment.  \"Ah.  Home.  It were a long time gone, kennit.  Your'n be not too far.  This'n… I don't think I want to talk 'bout it.  Too much metal atwixt now an' then.\""),
    replies = {
        {
            text = ccb.content.text("That's rough, maybe we should talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("What are you meaning with 'razzing up our green and brown'?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose2",
        },
        {
            text = ccb.content.text("How did you come to be made of metal like this?"),
            next_topic = "TALK_EXODII_MERCHANT_Metal",
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
