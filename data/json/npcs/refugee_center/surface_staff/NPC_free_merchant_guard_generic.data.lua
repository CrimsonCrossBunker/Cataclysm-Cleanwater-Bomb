local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_FM_SUNKEN_HELICOPTER_ANECDOTE",
    line = {
        choices = {
            ccb.content.text("Sure yeah, I remember, I was on caravan duty when I saw it, it got caught in of those weird storms, as we started driving away I heard a big splash sound."),
            ccb.content.text("No, sorry…"),
            ccb.content.text("I didn't see it myself but I heard the rumors about it, apparently it crashed somewhere nearby but I haven't seen any smoke or corpse."),
            ccb.content.text("Oh the helicopter?  Yeah, I tried finding the crash site around where the guy said he heard the crash but I didn't find nothing."),
            ccb.content.text("The crashed helicopter?  Eh, I'm pretty sure it's just a story, no one ever found anything."),
            ccb.content.text("Oh, yes, what a story, I almost wish I had been there to see it, almost."),
            ccb.content.text("Yeah I was part of the caravan that spotted it, it was headed east then when the storm broke out it got caught by some kind of creature, I heard gunshots then it started flying down rapidly, I heard it crash but I'm not sure where exactly."),
            ccb.content.text("Yes I was told the story by the others, I'm glad I wasn't there though, I hate those storms."),
            ccb.content.text("I dunno, I wasn't there but I overheard some guy talking about it."),
            ccb.content.text("You know how it is, people talk, I mean sure, there was one of those weird storms at the time but the helicopter story?  I don't believe it."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
