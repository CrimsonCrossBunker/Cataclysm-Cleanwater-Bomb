local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_SOMESHIT",
    line = ccb.content.text("Yeah.  I really did.  And I got scared.  I ran out into the woods to get away from all of the violence and death to try and make a plan to figure out how to get home and get safe.  But then when I was finally ready to face off against the monsters everything was still and the woods stretched on and on.  I don't know what happened."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
