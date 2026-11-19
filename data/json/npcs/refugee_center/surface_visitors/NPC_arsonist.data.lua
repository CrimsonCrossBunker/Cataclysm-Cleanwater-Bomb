local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_MUTATION_INSULT",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        yes = ccb.content.gendered_line("As if you're one to talk.  Screw You.", { "speaker" }),
        no = ccb.content.gendered_line("Screw You!", { "speaker" }),
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
