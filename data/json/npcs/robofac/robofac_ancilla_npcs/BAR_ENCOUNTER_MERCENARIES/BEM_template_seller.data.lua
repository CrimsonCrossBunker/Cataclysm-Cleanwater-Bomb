local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BEM_TEMPLATE_SELLER_NO_DEAL",
    line = ccb.content.text("Well I'm sure someone who values it will come around, thanks for hearing the pitch anyways."),
    on_enter = { { actions = { actions.set_actor_value("interlocutor", "dialog_negotiated", "yes") } } },
    replies = {
        {
            text = ccb.content.text("See you around then."),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}
