local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_GOBLIN",
    line = ccb.content.text("Good choice.  It seems that shortly before the world started to end, a few of them got it in their heads to just leave civilization alone for a bit and go live in the woods with other goblins.  And wargs.  Not a terrible idea if you ask me.  Anyways, there's a few different types of places they gather, are you looking for an encampment or an outpost?"),
    replies = {
        {
            text = ccb.content.text("An encampment."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN_ENCAMPMENT",
        },
        {
            text = ccb.content.text("An outpost."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN_OUTPOST",
        },
        { text = ccb.content.text("On second thought…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}
