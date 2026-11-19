local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Some day it would be nice to have a demographically selected chance of this not being heteronormative
ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_CALM",
    line = {
        when = predicates.actor_state("interlocutor", "female"),
        yes = ccb.content.text("Well, I have this weird hope.  It's probably stupid, but I saw my fiancé run out of there with his sister - my maid of honor - as things went bad.  So, until I run into them again one way or another, I'm just gonna keep on believing they're out there, doing well.  That's more than most of us have."),
        no = ccb.content.text("Well, I have this weird hope.  It's probably stupid, but I saw my fiancée run out of there with her brother - my best man - as things went bad.  So, until I run into them again one way or another, I'm just gonna keep on believing they're out there, doing well.  That's more than most of us have."),
    },
    replies = {
        { text = ccb.content.text("What were you saying before that?"), next_topic = "TALK_NONE" },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
