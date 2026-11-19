local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_MUTATION",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS", "LIGHTFUR" }),
        yes = ccb.content.text("Same way you got yours, I bet."),
        no = ccb.content.text("CRISPR?  Radiation?  Something in the water?  Maybe it was bunnies."),
    },
    replies = {
        { text = ccb.content.text("So it goes."), next_topic = "TALK_WARRENER" },
        {
            text = ccb.content.text("You're disgusting."),
            next_topic = "TALK_WARRENER_MUTATION_INSULT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_MUTATION_INSULT",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS", "LIGHTFUR" }),
        yes = ccb.content.text("I'm very sorry to tell you this, but you should look in a mirror."),
        no = ccb.content.text("Insulting people who could help you is unlikely to aid survival."),
    },
    replies = {
        {
            text = ccb.content.text("…"),
            success = {
                native_actions = { "end_conversation" },
                opinion = { trust = -1, fear = -2, value = -1, anger = 1 },
                next_topic = "TALK_DONE",
            },
        },
    },
}
