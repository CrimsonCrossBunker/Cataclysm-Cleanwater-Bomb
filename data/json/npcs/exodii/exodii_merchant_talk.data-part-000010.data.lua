local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Let me see.  Will do what I can for a coin.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue",
    line = ccb.content.text("Lemme poke.  Will tass what ye can for a shiny."),
    replies = {
        {
            text = ccb.content.text("[Prototype Cyborg] Can you help this guy it seems like they have lost their mind?"),
            when = predicates.has_inventory("speaker", "bot_prototype_cyborg", 1),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Prototype_Cyborg_Rescue",
        },
        {
            text = ccb.content.text("[Broken Cyborg] Can you save my buddy who looks a bit rough around the edges, but they still haven't flatlined?"),
            when = predicates.has_inventory("speaker", "bot_broken_cyborg", 1),
            next_topic = "TALK_EXODII_MERCHANT_Experiment_Broken_Cyborg_Rescue",
        },
        {
            text = ccb.content.text("Actually, forget it's not my problem."),
            next_topic = "TALK_DONE",
        },
    },
}
