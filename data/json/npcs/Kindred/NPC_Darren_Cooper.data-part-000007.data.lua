local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_KNOWBRIG",
    line = ccb.content.text("Small world, huh?  I hope she's doing fine.  Despite our differences, I owe everything to her.  I hope one day we'll be able to reconcile."),
    replies = {
        {
            text = ccb.content.text("So, how do you know that any of this works?"),
            next_topic = "TALK_COOPER_WORK",
        },
        {
            text = ccb.content.text("What differences?  Why did you part ways?"),
            next_topic = "TALK_COOPERS_SIDE",
        },
    },
}
