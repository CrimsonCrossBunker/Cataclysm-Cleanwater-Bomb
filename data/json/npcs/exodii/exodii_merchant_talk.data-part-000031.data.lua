local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii",
    line = ccb.content.text(
        --~ Ah, you found another node - another community of Exodii.  Tell me what you saw?
        "Ahh, mayhaps ye've found another node - kin o' us'n Exodii.  Tell ol' Rubik:  what'd ye escolt there?  Exodii alive?  Trade?  Stompers?  Manufactory?"),
    replies = {
        {
            text = ccb.content.text("It was a large domed structure, with some towers around it.  The entire thing looked like it was made of metal - a lot like your castle.  Looked like it was a ruin, or abandoned.  If there was anyone alive, I didn't find them."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
