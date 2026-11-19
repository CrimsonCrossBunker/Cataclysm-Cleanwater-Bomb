local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Same as you, I'd guess.  The Enemy.  The dead.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus2",
    line = ccb.content.text("Same as you will be, an I'm ken.  The Enemy.  The dead."),
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodii_transdimensional_u_knows_exodiilore" } }),
            text = ccb.content.text("Wait, am I following this right?  You're from a place where this happened before, and you escaped to our world?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodus3",
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
