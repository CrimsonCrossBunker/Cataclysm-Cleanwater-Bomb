local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT",
    replies = {
        {
            text = ccb.content.text("What can you tell me about the dinosaurs?"),
            next_topic = "TALK_EXODII_MERCHANT_DINOSAURS",
        },
    },
}

-- Yes, and what can I tell you about the grass being green and the sun being yellow?  All of the large baby chickens do what they do and we get no benefit from it regardless of what we say about them.  Why do you ask, you person with a physical body?  Do you like the big turkeys?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DINOSAURS",
    line = ccb.content.text("Aye, 'n what c'n I yark'n ye around the grassins what be a'green 'n that the big brassy what be a'yeller?  All'n those great chickees do what they do 'n we profit none 'n the immortalinity of the crabs consists just so. What of it ye long and bobbly?  Ye takin' a shinin' to the jibble-necks?"),
    replies = {
        { text = ccb.content.text("This was unhelpful."), next_topic = "TALK_EXODII_MERCHANT" },
        {
            text = ccb.content.text("Are you really this nonchalant about the dinosaurs?"),
            next_topic = "TALK_EXODII_MERCHANT_DINOSAURS_2",
        },
    },
}

-- Yes, and yes again.  If every world has zombies, 90% of the ones we reach have dinos.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DINOSAURS_2",
    line = ccb.content.text("Aye, n'aye again!  E'ry ball o mud has the Enemy.  Nine mudballs out o' ten  are mudded up wit thunder chickees."),
    replies = {
        {
            text = ccb.content.text("I wonder why most worlds have dinosaurs roaming?"),
            next_topic = "TALK_EXODII_MERCHANT",
        },
    },
}
