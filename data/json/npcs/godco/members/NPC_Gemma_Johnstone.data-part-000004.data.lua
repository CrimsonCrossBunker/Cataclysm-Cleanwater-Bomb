local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Mood",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_gemma_got_supplements" } }),
        yes = ccb.content.text("I'm feeling great!  Even if the world's over, I always have myself and God above."),
        no = ccb.content.text("I'm feeling alright, just working away."),
    },
    replies = {
        {
            text = ccb.content.text("I'm happy to hear that, Gemma.  I'd best be going."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_gemma_got_supplements" } }),
        },
        {
            text = ccb.content.text("I'll see you around."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_gemma_got_supplements" } })),
        },
    },
}
