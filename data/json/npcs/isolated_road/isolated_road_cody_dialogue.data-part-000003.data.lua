local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_SHOP_ABOUT_STUPID_QUESTION",
    line = {
        choices = {
            ccb.content.text("Honey, I have a hard time finding a bra that fits.  Good luck finding a breastplate."),
        },
    },
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
        {
            text = ccb.content.text("Tell me about it, finding anything that fits in this apocalypse has been a nightmare."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        { text = ccb.content.text("Oh, uh.  Right, uh."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}
