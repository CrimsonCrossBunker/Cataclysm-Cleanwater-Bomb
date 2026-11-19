local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Confessed",
    line = {
        when = predicates.actor_state("speaker", "male"),
        yes = ccb.content.text("We all have, brother, we all have."),
        no = ccb.content.text("We all have, sister, we all have."),
    },
    replies = { { text = ccb.content.text("Thanks for your time, Reverend."), next_topic = "TALK_DONE" } },
}
