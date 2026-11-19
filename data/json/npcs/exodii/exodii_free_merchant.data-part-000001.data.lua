local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_FREE_MERCHANT",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            yes = ccb.content.text("Well, an Exodii… and a U.S marshal.  That's not something you see every day."),
            no = {
                choices = {
                    ccb.content.text("Still plenty of outlaws in the roads, perhaps you should tend to your job, marshal…"),
                    ccb.content.text("You see anything you want, marshal?"),
                    ccb.content.text("Oh, a U.S. marshal."),
                },
            },
        },
        no = {
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            yes = {
                choices = {
                    ccb.content.text("Ah, an Exodii?  Welcome…"),
                    ccb.content.text("An Exodii?  Here to trade, I hope?"),
                    ccb.content.text("Safe travels, Exodii."),
                },
            },
            no = {
                choices = {
                    ccb.content.text("Welcome…"),
                    ccb.content.text("Here to trade, I hope?"),
                    ccb.content.text("Safe travels, scavenger."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_EXODII_FREE_MERCHANT",
        },
        {
            text = ccb.content.text("When is the next shipment?"),
            next_topic = "TALK_EXODII_FREE_MERCHANT_INTERVAL",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_EXODII_FREE_MERCHANT_DOING",
        },
        {
            text = ccb.content.text("I'm not an Exodii, I'm just a cyborg."),
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            next_topic = "TALK_EXODII_FREE_MERCHANT_EXODII",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
