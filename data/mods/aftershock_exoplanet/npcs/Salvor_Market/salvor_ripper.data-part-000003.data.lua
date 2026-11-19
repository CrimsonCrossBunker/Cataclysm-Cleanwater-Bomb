local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_MERCURIAL_IDENTS",
    line = ccb.content.text("&The ripper's eyes widen as they see the data shard you are showing them.  They snatch it out of your hand and quickly scan it with their wrist computer.  After a moment, they look up at you with a new level of respect.  \"… these are legit.  Where did you even get these?\""),
    replies = {
        {
            text = ccb.content.text("You know, here and there.  I want 60K."),
            next_topic = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_SELL",
        },
        {
            text = ccb.content.text("Well I was thinking 20K and you keeping me in mind for future deals."),
            next_topic = "TALK_SALVOR_RIPPER_MERCURIAL_IDENTS_FAVOUR",
        },
    },
}
