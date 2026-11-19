local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "HUB01_DNovak_Intro",
    line = {
        when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        yes = ccb.content.text("Oh, hey.  The rumors were true, there really is someone new around.  Nice to meet you, call me Darla."),
        no = ccb.content.text("Who the fuck are you?  How did you get down here?  Security!"),
    },
    replies = {
        {
            text = ccb.content.text("Hold on, hold on.  I'm not here to hurt anyone, and there aren't enough of us left to just start fighting."),
            when = predicates.negate(predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY")),
            next_topic = "TALK_DONE",
            actions = { "flee" },
        },
        {
            text = ccb.content.text("Nice to meet you too."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_DNovak", "yes") },
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        },
    },
}
