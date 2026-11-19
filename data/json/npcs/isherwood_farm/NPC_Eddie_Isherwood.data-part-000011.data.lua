local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EDDIE_CARLOS",
    line = ccb.content.text("Carlos will be in his workshop if he isn't out hunting.  He is trying to get a forge set up."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_about_forge", "yes") } } },
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
