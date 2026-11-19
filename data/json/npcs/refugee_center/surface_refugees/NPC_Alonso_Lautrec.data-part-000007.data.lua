local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Too_Young",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Sorry kid, you're younger than my little sister was.  Seems wrong."),
        no = ccb.content.text("Alonso thinks maybe we should wait a few years?"),
    },
    replies = { { text = ccb.content.text("Sigh."), next_topic = "TALK_DONE" } },
}
