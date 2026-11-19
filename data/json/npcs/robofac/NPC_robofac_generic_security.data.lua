local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_HUB_SECURITY",
    line = {
        choices = {
            ccb.content.text("Keep it civil, merc."),
            ccb.content.text("Just on watch, move along."),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = { choices = { ccb.content.text("Sir.") } },
                no = { choices = { ccb.content.text("Ma'am") } },
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
