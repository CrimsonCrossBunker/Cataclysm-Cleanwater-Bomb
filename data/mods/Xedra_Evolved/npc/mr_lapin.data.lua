local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("What can you tell me about Xedra?"),
            next_topic = "TALK_WARRENER_XEDRA",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_XEDRA",
    line = ccb.content.text("Are you talking about the Zebra agencies?  I probably don't know any more than you do.  When things started getting weird about a decade ago, all these new departments starting springing up out of Homeland Security.  Their badges were just barcodes that if you scanned with your phone would put you in contact with your local law enforcement, who'd vouch for them."),
    replies = {
        {
            text = ccb.content.text("I just keep finding references to them, I wondered if anyone else was as well."),
            next_topic = "TALK_WARRENER",
        },
    },
}
