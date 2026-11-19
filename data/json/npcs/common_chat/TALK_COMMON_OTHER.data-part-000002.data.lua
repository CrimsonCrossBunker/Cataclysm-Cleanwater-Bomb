local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SHELTER_ADVICE",
    line = { special = "hint" },
    replies = { { text = ccb.content.text("Thanks!"), next_topic = "TALK_NONE" } },
}
