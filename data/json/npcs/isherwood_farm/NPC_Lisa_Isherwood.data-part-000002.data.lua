local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_CHRIS2",
    line = ccb.content.text("Well, he's supposed to be hunting, but since you've been talking to Luke, I bet he mentioned Chris wants to learn more about the end of the world.  Sometimes he'll take off for a few days and I end up patching him up so my parents don't know he left the property."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_heard_about_lukefromlisa", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
