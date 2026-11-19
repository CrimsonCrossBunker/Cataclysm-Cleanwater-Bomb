local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_MOTIVATES",
    line = ccb.content.text("I… I mean… huh.  I guess."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_cowboyn_cowboynmots", "yes") } } },
    replies = {
        { text = ccb.content.text("Good.  Take care."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("That's a start."), next_topic = "TALK_COWBOYN_MAIN" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_MOTIVATEF",
    line = ccb.content.text("Just leave me alone."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "dialogue_cowboyn_cowboynmota", "yes") } } },
    replies = {
        { text = ccb.content.text("Alright.  Take care."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Fine."), next_topic = "TALK_DONE" },
    },
}
