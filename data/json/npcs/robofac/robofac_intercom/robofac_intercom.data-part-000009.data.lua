local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_EXODII_MORE_INFO",
    line = ccb.content.text("We need more information on these folks, we will be making covert visual contact ourselves but for obvious reasons we can't get inside information without alerting these guys.  That's where you come in…we want you to gather as much information on these people without raising any suspicions and bring it back to us.  Most importantly find who they are and why are they here."),
    replies = {
        {
            text = ccb.content.text("Right.  I'll be back with the juicy details."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I don't know man sounds kind of dangerous.  What can I expect in return?"),
            next_topic = "TALK_ROBOFAC_EXODII_INFO_REWARD",
        },
        {
            text = ccb.content.text("Absolutely not, these guys are far more powerful than me and one wrong move will get me killed, besides I'm no rat."),
            next_topic = "TALK_DONE",
        },
    },
}
