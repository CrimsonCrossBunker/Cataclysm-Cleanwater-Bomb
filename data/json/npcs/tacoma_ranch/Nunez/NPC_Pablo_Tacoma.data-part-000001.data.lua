local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Pablo_1",
    line = ccb.content.text("*looks up at you from a ledger, takes a moment to place you, then smiles broadly.  \"Great to see you, my friend.  To what do I owe the pleasure?\""),
    replies = {
        {
            text = ccb.content.text("Hi, Pablo!  How are things going here?"),
            next_topic = "TALK_TACOMA_Pablo_2",
        },
        {
            text = ccb.content.text("Hello, Pablo!  What's with the trailer?"),
            next_topic = "TALK_TACOMA_Pablo_Trailer1",
        },
        {
            text = ccb.content.text("Hey, Pablo!  I heard you might be willing to trade for propane?"),
            next_topic = "TALK_TACOMA_Pablo_Propane1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_propane_scavenging" } }),
        },
        {
            text = ccb.content.text("Hey, Pablo!  Dana said you had some plans to build a bakery?"),
            next_topic = "TALK_TACOMA_Pablo_Bakery1",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_tacoma_bakery" } }),
        },
        {
            text = ccb.content.text("Just popping in to say hi.  Talk to you later!"),
            next_topic = "TALK_DONE",
        },
    },
}
