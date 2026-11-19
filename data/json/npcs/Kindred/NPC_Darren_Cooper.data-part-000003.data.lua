local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_COOPERS_SIDE",
    line = ccb.content.text("I met Brigitte shortly after everything collapsed.  Seeing so much death and insanity around me… it almost crushed me, but when she explained everything about the bones to me, it gave me a sliver of hope, that one time, things might turn around.  For that, I am grateful to her.  But we'll never change anything if we keep using scraps of bones found on corpses on the side of the road.  By the time the animals are done with those, there is barely any Song left to be used.  It's not enough.  I had to leave, to work on my own.  To do what's necessary."),
    replies = {
        {
            text = ccb.content.text("What do you mean by 'necessary'?"),
            next_topic = "TALK_COOPER_NECESSARY",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } })),
        },
        {
            text = ccb.content.text("What are you actually trying to accomplish?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })),
        },
        {
            text = ccb.content.text("Can't have been easy to split off, but I understand why you did it."),
            next_topic = "TALK_COOPER_AGREE",
        },
        {
            text = ccb.content.text("Necessary?  You kill innocent people!"),
            next_topic = "TALK_COOPER_NECESSARY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper_kill" } }),
        },
    },
}
