local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_FAIL",
    line = ccb.content.text("&The ripper scoffs at you, clearly not taking you seriously.  \"Come back when you know what you're doing.\""),
    on_enter = { { actions = { actions.set_first_topic("TALK_SALVOR_RIPPER_IGNORE") } } },
    replies = {
        { text = ccb.content.text("I don't think I will."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Yeah.  Sure thing."), next_topic = "TALK_DONE" },
    },
}
