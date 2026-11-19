local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Follow",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_jane_willing_to_follow" } }),
        yes = ccb.content.text("I'm up for it, Arturo's got enough medicine for two-and-half months.  It's thankless work around here, so let's blow this joint."),
        no = ccb.content.text("I'd like to leave, but I've got to take care of Arturo.  He's always low or nearly out of antipsychotics, so I do what I can."),
    },
    replies = {
        {
            text = ccb.content.text("Alright.  Wanna chat?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_jane_willing_to_follow" } })),
            next_topic = "TALK_GODCO_Jane_2",
        },
        {
            text = ccb.content.text_without_extraction("<lets_go>"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_jane_willing_to_follow" } }),
            native_actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}
