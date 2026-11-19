local ccb = require("ccb")

-- It means what it means.  Your land's dead already, it's just still kicking is all.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose4",
    line = ccb.content.text("Means what it means.  Your land's a deadun', still kickin' is all."),
    replies = {
        {
            text = ccb.content.text("Are you saying you think we're doomed?  Why would you have come here if there wasn't some way to survive?"),
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
