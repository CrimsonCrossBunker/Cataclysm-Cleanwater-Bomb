local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Story",
    line = ccb.content.text("&Julian suddenly appears disturbed, and looks away from you for a moment.  \"It's a long story, and not an interesting one at that.  I was a cop before.  You must've heard about those riots and all that.  I'm glad we all managed to make it out alive.\""),
    replies = {
        {
            text = ccb.content.text("How did you make it out?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_told_backstory" } })),
            trial = { kind = "persuade", difficulty = 30 },
            failure = { next_topic = "TALK_GODCO_Julian_NoChat" },
            success = { next_topic = "TALK_GODCO_Julian_Riots" },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
