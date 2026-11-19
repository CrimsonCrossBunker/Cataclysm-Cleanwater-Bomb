local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MSU14_HACK_FAILURE",
    line = ccb.content.text("&<color_red>ERROR</color>"),
    on_enter = { { actions = { actions.set_actor_value("speaker", "computer_hacking_msu14_hack", "yes") } } },
    replies = { { text = ccb.content.text("Return"), next_topic = "MSU14_MAIN" } },
}
