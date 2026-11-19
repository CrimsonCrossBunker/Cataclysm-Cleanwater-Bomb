local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EDDIE_LUKE",
    line = ccb.content.text("Luke was going to start college this year, now everything is upside down.  He is adaptable though, had an idea to begin manufacturing our own jars and pottery.  He's out in the old outbuilding right now, cleaning up the place."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_heard_about_luke", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
