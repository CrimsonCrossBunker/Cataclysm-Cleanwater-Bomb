local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_SOCIAL",
    line = ccb.content.text("Yes, thank you for sharing with me.  So what are you doing here?  What are you trying to accomplish?"),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm just trying to survive."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("[INT 14] I'm trying to understand what happened and see if I can make something better happen."),
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("I'm trying to become more powerful than whatever else is out there."),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("I'm trying to make a survivor settlement.  You should join!"),
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
    },
}
