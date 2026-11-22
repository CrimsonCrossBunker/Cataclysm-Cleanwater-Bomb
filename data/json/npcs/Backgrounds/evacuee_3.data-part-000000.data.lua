local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY1",
    line = ccb.content.gendered_line("There's nothing too special about me, I'm not sure why I survived.  I got evacuated with a handful of others, but we were too late to make the second trip to a FEMA center.  We got attacked by the dead… I was the only one to make it out.  I never looked back.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How did you survive after that?"),
            next_topic = "BGSS_EVACUEE_3_STORY2",
            when = predicates.handler("dlg_p_dda_726627078ec1"),
            actions = { actions.add_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting", { permanent = true }) },
        },
        {
            text = ccb.content.text("How did you survive after that?"),
            next_topic = "BGSS_EVACUEE_3_STORY2",
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
