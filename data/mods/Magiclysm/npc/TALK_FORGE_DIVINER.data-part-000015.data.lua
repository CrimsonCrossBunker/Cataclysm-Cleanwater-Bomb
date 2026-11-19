local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_GOD",
    line = ccb.content.text("Valzain is in the back, down in the vault, selling overpriced magical knick-knacks.  Or perhaps there was something else you had in mind?"),
    replies = {
        {
            text = ccb.content.text("Another forge?"),
            next_topic = "TALK_FORGE_LORD_DIVINER_OTHER_FORGE",
        },
        {
            text = ccb.content.text("A Lovecraftian horror."),
            next_topic = "TALK_FORGE_LORD_DIVINER_LOVECRAFTIAN",
        },
        {
            text = ccb.content.text("The Malignance."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MALIGNANCE",
        },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_OTHER_FORGE",
    line = ccb.content.text("There is only one Forge of Wonders.  It's not like this is a multidimensional franchise opportunity."),
    replies = {
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}
