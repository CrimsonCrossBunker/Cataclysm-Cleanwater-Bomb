local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- This is a deadland, don't you see?  You've already got an infestation and it's not going away.  There's no cure for the zombies.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose3",
    line = ccb.content.text("This'n be a deadland, an I'm ken.  You gots you a case o' the willies ain't gonna sing along.  No cure for these rats and fleas."),
    replies = {
        {
            text = ccb.content.text("What the hell does that mean?"),
            next_topic = "TALK_EXODII_MERCHANT_Purpose4",
        },
        {
            text = ccb.content.text("[INT 8] Are you saying you think we're doomed?  Why would you have come here if there wasn't some way to survive?"),
            when = predicates.minimum_attribute("speaker", "intelligence", 8),
            next_topic = "TALK_EXODII_MERCHANT_Survival",
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
