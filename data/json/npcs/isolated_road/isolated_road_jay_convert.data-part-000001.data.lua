local ccb = require("ccb")

-- this is all the dialogue related to converting bullets with Jay
ccb.content.define_dialogue_topic {
    id = "TALK_BULLET_EXCHANGE_INFO",
    line = ccb.content.text("You hit the nail on the head.  You bring me cartridges of one type, and I reload them into another.  Ammo has its own exchange rate, for example, you can exchange a hundred rifle rounds for three hundred pistol rounds or vice versa."),
    replies = {
        {
            text = ccb.content.text("Can we do that now?"),
            next_topic = "TALK_GUNSMITH_CONVERT_FROM_TYPE",
        },
        {
            text = ccb.content.text("Thanks for filling me in."),
            next_topic = "TALK_GUNSMITH_SERVICES",
        },
    },
}
