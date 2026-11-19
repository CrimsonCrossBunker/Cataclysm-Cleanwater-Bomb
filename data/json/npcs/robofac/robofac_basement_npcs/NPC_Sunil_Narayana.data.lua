local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "HUB01_SNarayana_Intro",
    line = {
        when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        yes = ccb.content.text("Oooh, the NEW person.  So, you're not just some rumor they cooked up as a team building exercise.  I'm Sunil, welcome to the underground."),
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
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_SNarayana", "yes") },
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
        },
    },
}
