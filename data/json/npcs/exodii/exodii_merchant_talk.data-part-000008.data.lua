local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Ongoing",
    line = ccb.content.text("Nah, mate, still operatin'."),
    replies = {
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        { text = ccb.content.text("Ok.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
