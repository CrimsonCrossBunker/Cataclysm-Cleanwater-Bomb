local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_BANKET",
    line = ccb.content.text("Dangerous?  It may look different, but this land cares and provides for us.  We are celebrating with a feast, in fact.  Do you care to join us?"),
    replies = {
        { text = ccb.content.text("Well, sure."), next_topic = "TALK_MARLOSS_VOICE_OFFER_BERRY" },
        { text = ccb.content.text("I'd… rather not."), next_topic = "TALK_MARLOSS_VOICE" },
        { text = ccb.content.text("I'm sorry… I have places to be."), next_topic = "TALK_DONE" },
    },
}
