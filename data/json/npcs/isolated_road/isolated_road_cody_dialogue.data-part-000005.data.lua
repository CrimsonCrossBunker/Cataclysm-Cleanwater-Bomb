local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_BOUGHT_COOP",
    line = {
        choices = {
            ccb.content.text("There yah go, one co-op membership with your name on it.  Shop's in the back, keep it tidy and share if anyone else is around workin'.  Just as a heads-up, you'll need to bring your own charcoal.  There's a kiln in there too, so if you got things to burn, just throw 'em in there and light up."),
        },
    },
    replies = {
        { text = ccb.content.text("Thanks."), next_topic = "TALK_BLACKSMITH_SERVICES" },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_MONEY_RAMBLE",
    line = {
        choices = { ccb.content.text("Money is part of what got us into this mess in the first place.") },
    },
    replies = {
        {
            text = ccb.content.text("Is that why you don't carry any cash?"),
            next_topic = "TALK_BLACKSMITH_MONEY_NO_CASH",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_MONEY_NO_CASH",
    line = {
        choices = { ccb.content.text("B-I-N-G-O.  If you bring it, I'll take it, but that's about it.") },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" } },
}
