local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_MONSTER",
    line = ccb.content.gendered_line("And how many people have you killed?  Maybe it was in self defense, maybe because you wanted their gear.  It's all the same.  I give their death meaning.  I hate that I have to do it, I truly do, but you really must understand, there is no other way.  The sooner I finish my mission, the sooner all this madness can end.", { "speaker" }),
    replies = {
        { text = ccb.content.text("I suppose you're right."), next_topic = "TALK_COOPER_AGREE" },
        {
            text = ccb.content.text("You're mad.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        { text = ccb.content.text("Whatever.  I'm leaving."), next_topic = "TALK_DONE" },
    },
}
