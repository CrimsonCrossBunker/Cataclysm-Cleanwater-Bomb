local ccb = require("ccb")

-- Note: the part about the kill being in melee only is due to bug #72281.  Remove it when the bug gets fixed
ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SACRIFICE_1" },
    line = ccb.content.text("They need to be completely trusting of you, someone that consider themselves your \"best friend forever\".  They also need to declare how much they love you right before you kill them, then you'll become a true vampire.  And I almost forgot: you also need to kill them in melee combat or else it won't work.\n\nAnd when you are done, return to me.  There is more that you must learn."),
    replies = { { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" } },
}

-- Note: the part about the kill being in melee only is due to bug #72281.  Remove it when the bug gets fixed
ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SACRIFICE_2" },
    line = ccb.content.text("Do not worry about the pain, my friend.  It is always temporary, no matter how much it hurts.  After that, you won't ever be temporary again.  Keep in mind that they need to be completely trusting of you, someone that consider themselves your \"best friend forever\".  They also need to declare how much they love you right before you kill them, then you'll be freed from your limited time as you become a true vampire.  And I almost forgot: you also need to kill them in melee combat or else it won't work.\n\nAnd when you are done, return to me.  There is more that you must learn."),
    replies = { { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_GATHER_TIER_5" },
    line = ccb.content.text("Here's the book.  It contains everything you need to know about the components you need to acquire.  Be sure to read it thoroughly as the rituals have very specific conditions to be accomplished.  Come back here when you'll have them all and you will fully walk the path."),
    replies = {
        {
            text = ccb.content.text("Thank you.  I'll bring back these components."),
            next_topic = "TALK_DONE",
        },
    },
}
