local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro3",
    line = ccb.content.text(
        --~ We've got to leave the old world before it gets too worn out, you see, and find a nice fresh one on the other side.  Your deadland is as fresh as it gets.
        "Us gotta leave the old world afore it's worn right to the gums, an y'ken, and find a nice twitchy one on t'other side.  Your deadland be a brand shiny"),
    replies = {
        {
            text = ccb.content.text("I'm not following that at all."),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro3a",
        },
        {
            text = ccb.content.text("[INT 9] So you mean, we have a nice, freshly dead world for you to visit?"),
            when = predicates.minimum_attribute("speaker", "intelligence", 9),
            next_topic = "TALK_EXODII_MERCHANT_Talk_Intro4b",
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
