local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_KILL_PLAYER",
    line = ccb.content.text("No.  You seem like you have a chance of surviving in this world.  Plus, you took the time to actually hear me out, so there is a chance one day you'll hear the Song the same way I do."),
    replies = {
        {
            text = ccb.content.text("Nevertheless, I can't allow you to keep killing people."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        {
            text = ccb.content.text("I'm glad you see it that way."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.negate(predicates.has_trait("speaker", "seer_mark")),
        },
        {
            text = ccb.content.text("Maybe one day I will."),
            next_topic = "TALK_COOPER_AGREE",
            when = predicates.has_trait("speaker", "seer_mark"),
        },
        {
            text = ccb.content.text("This is a waste of time.  I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}
