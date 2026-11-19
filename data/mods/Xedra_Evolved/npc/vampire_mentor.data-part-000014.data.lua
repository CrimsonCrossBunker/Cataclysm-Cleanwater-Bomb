local ccb = require("ccb")

-- the lore is that a bunch of vampires decided to try and make becoming a true vampire as accessible as possible.  Some of them are doing it out of wanting to help new vampires, most are in to make many powerful vampires to fight the hunters, a few have other motivations.  This lore isn't communicated to the player.
ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_WE" },
    line = ccb.content.text("I'm not the only vampire looking to assist others on the path.  We wrote this book together and occasionally meet to update and refine it, all in the goal of helping new vampires reach their true potential as easily as possible."),
    replies = {
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Where are these other mentors?"),
            next_topic = "TALK_VAMPIRE_MENTOR_WE_WHERE",
        },
        { text = ccb.content.text("See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_WE_WHERE" },
    line = ccb.content.text("I do not know of their whereabouts.  All what matters is that we know where to meet, but with the end of the world all meetings has been postponed indefinitely."),
    replies = {
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECAME_TIER_5" },
    line = ccb.content.text("You have now reached the apex of the vampiric condition and do not need further guidance.  Go forth and claim your title and crown of ruler of the night!  Make it clear that you are the one on the throne!"),
    replies = { { text = ccb.content.text("Got it.  Farewell, my friend."), next_topic = "TALK_DONE" } },
}
