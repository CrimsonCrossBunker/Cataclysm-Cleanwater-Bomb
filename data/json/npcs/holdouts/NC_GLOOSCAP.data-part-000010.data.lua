local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_FEAR",
    line = ccb.content.text("Whoah whoah, calm down.  Yikes.  Yeah fine, we're good.  Just stop trying to spook me, I don't like it."),
    replies = {
        {
            text = ccb.content.text("Yes, that worked great."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("We are not good and I'm done talking to you."),
            next_topic = "TALK_DONE",
        },
    },
}
