local ccb = require("ccb")

-- Remember, we picked you because you speak this Earth's English.  But I know you're no negotiator.  Beyond that, well, our expectations are low.  No offense.  Take it slow.  Five minutes of polite conversation will exceed my expectations.  Try not to cause any sort of real problems, please?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_0-2",
    line = ccb.content.text("Keep keen.  We chose ye' cause ye' speak their Anglic.  But ol' Rubik knows yer' no parley barley.  Beyond that, well… let's call this an experiment in optimism.  Go easy, aye?  Five minutes'o polite conversation an ye'll exceed expectation.  Try not t'cause any real problems, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

-- Remember, you're introducting traders, not making threats.  If they start backing away while taking, try smiling.  If that makes it work, stop smiling.  You've clearly got some sense.  Follow it.  Try not to cause any incidents.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_3-4",
    line = ccb.content.text("Remember yer a trader not a threater.  If folk back away, try smilin'.  If they don't like that, stop.  Ye' got a pinch of sense.  Follow it.  Try not t'cause any incidents, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

-- You're good enough with people.  Better than most surivivors.  Keep it friendly, don't mention the Enemy, and don't make expensive promises, please.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_5-6",
    line = ccb.content.text("Ye've decent enough people-sense.  Better'an most scavvers.  Keep the yark friendly, don't menton the Enemy, an' try not t'promise anything too expensive, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

-- I can tell you're good at this, and I trust you more than I should.  If you get us a good deal, I'll owe you.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_7-8",
    line = ccb.content.text("Got more faith'in'ye than Ol' Rubik mayhaps should.  If these Free Merchants leave thinkin' us'n are respectable traders instead'a vagabonds, ol' Rubik'll owe ye a favor.  And I don't say that lightly, aye?"),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}

-- I know you're good at this.  Sometimes I forget you're just a survivor, and not some sort of diplomat.  Try not to do better than I would do, yeah?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_accepted_9-10",
    line = ccb.content.text("&\"Tell ye' true, I often forget ye're a scavver and not some sorta' treat-an'-sweety.  Do try not t'negotiate a bettter deal than ol' Rubik woul've got 'imself, aye?\"  Rubik chuckles."),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_DONE" } },
}
