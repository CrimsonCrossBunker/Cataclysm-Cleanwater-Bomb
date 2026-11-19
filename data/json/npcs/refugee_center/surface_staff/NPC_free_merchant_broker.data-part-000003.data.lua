local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_BEGGARS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
        yes = ccb.content.text("I do.  I don't know what you did to convince them to move out, but our supply chain and I both thank you.  I hope it wasn't too unseemly."),
        no = ccb.content.text("Even once we got things sorted out, there weren't enough beds for everyone, and definitely not enough supplies.  These are harsh times.  We're doing what we can for those folks… at least they've got shelter."),
    },
}
