local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_1_STORY1",
    line = ccb.content.gendered_line("I made it to one of those <freaking> evac shelters, but it was almost worse than what I left behind.  Escaped from there, been on the run since.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How did you survive on the run?"),
            next_topic = "BGSS_EVACUEE_1_STORY2",
            when = predicates.handler("dlg_p_dda_726627078ec1"),
            actions = { actions.add_effect("interlocutor", "BGSS_EVACUEE_1_earlymeeting", { permanent = true }) },
        },
        {
            text = ccb.content.text("How did you survive on the run?"),
            next_topic = "BGSS_EVACUEE_1_STORY2",
            when = predicates.handler("dlg_p_dda_3b14879c9833"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
