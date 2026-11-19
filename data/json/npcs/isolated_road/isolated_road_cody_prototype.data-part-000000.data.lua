local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE_NOT_FEELING_IT",
    line = {
        choices = {
            ccb.content.text("Oh, these.  With the end of the world, Jay and I had been talking about some new projects for the wasteland warriors.  Anyways, it doesn't matter anymore since… well, it doesn't matter."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Are you and Jay close?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_accepted_quest" } })),
            next_topic = "TALK_BLACKSMITH_JAY",
        },
        {
            text = ccb.content.text("I'm sure we'll fix things soon!"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_accepted_quest" } }),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}
