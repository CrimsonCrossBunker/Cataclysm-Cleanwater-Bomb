local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_MUTATION",
    line = {
        when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        yes = ccb.content.text("Same way you got yours, I bet.  Keep quiet about it, some people here look down on people like us."),
        no = ccb.content.text("Ssh.  Some people in here hate… mutations.  This was an accident."),
    },
    replies = {
        { text = ccb.content.text("Sorry to ask."), next_topic = "TALK_ARSONIST" },
        {
            text = ccb.content.text("You're disgusting."),
            next_topic = "TALK_ARSONIST_MUTATION_INSULT",
        },
    },
}
