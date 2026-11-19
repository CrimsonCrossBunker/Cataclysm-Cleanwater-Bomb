local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_HQ_GUARD_AskJob",
    line = {
        choices = {
            ccb.content.text("Me?  Just standing around, looking scary.  Think I'm doing a good job?\n\nDon't answer that."),
            ccb.content.text("Just making sure people don't ask stupid questions."),
            ccb.content.text("I'm just on watch, move along."),
            ccb.content.text("Getting paid for standing around.  And you are getting in the way."),
            ccb.content.text("A few of us joined up to make this a safe house, and it's just my turn watching the gates."),
            ccb.content.text("Just go down to the Terminal if you want in."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_HQ_GUARD_AskJoin",
    line = ccb.content.text("Well you certainly look like you could.  Try ringing the box in the bunker across the street, or see if someone in the Terminal has a need for help."),
}
