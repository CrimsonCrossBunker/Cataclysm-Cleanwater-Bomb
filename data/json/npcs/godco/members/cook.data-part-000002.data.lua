local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_family",
    line = ccb.content.text("Katherine's probably in the bunks right now, and Jeremiah's next door.  Feel free to say hello sometime."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "general_meeting_u_know_about_family", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("Who's Katherine?"), next_topic = "TALK_GODCO_chef_katherine" },
        { text = ccb.content.text("Who's Jeremiah?"), next_topic = "TALK_GODCO_chef_jeremiah" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_chef",
        },
        { text = ccb.content.text("I'll do that."), next_topic = "TALK_DONE" },
    },
}
