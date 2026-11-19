local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER",
    line = ccb.content.text("Are you looking for something?  I can help with anything but your own stuff.  You'll have to ask your mother for help with that."),
    replies = {
        {
            text = ccb.content.text("Can you help me find something?"),
            next_topic = "TALK_FORGE_DIVINER_FIND_WHAT",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_DIVINER_DOING",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_DIVINER_DOING",
    line = ccb.content.text("What are any of us really doing here in this dead and dying world?  I specialize in scrying, and while I wish I could say I'm in it to help lost souls find their way, the collective pockets of a thousand realities is a very good incentive.  I can help you find any number of things, but I take no responsibility for what happens when you find what you're looking for."),
    replies = {
        {
            text = ccb.content.text("Let's talk business then."),
            next_topic = "TALK_FORGE_LORD_DIVINER",
        },
    },
}
