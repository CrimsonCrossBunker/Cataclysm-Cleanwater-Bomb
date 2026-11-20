local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Dialect",
    line = ccb.content.text(
        --~ Sure you can, at least a bit.  I'll do my best to speak your Anglic, but seeing as we're from otherlands and all, it's not that simple.
        "Sure as ye can, at least sommat.  Us'n'll try as we might to parley your Anglic, but so ye kennit as us be from otherlands and all, it ain't that simple."),
    replies = {
        {
            text = ccb.content.text("[INT or PER 7] How come you speak English, or uh, 'Anglic' like that?"),
            when = predicates.any({ predicates.minimum_attribute("speaker", "intelligence", 7), predicates.minimum_attribute("speaker", "perception", 7) }),
            next_topic = "TALK_EXODII_MERCHANT_Dialect_Anglic",
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
