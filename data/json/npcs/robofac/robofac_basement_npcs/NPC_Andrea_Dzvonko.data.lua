local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "HUB01_ADzvonko_Intro",
    line = {
        when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        yes = ccb.content.text("Woah, you must be that new person they told us about.  I can't really believe you're here.  I'm Andrea.  Dr. Dzvonko in the old days, but that seems silly now."),
        no = ccb.content.text("Who the fuck are you?  How did you get down here?  Security!"),
    },
    replies = {
        {
            text = ccb.content.text("Hold on, hold on.  I'm not here to hurt anyone, and there aren't enough of us left to just start fighting."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY")),
            actions = { "flee" },
        },
        {
            text = ccb.content.text("Nice to meet you too."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_ADzvonko", "yes") },
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        },
    },
}
