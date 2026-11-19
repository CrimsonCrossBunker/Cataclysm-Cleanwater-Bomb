local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_FREE_MERCHANT",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("Still plenty of outlaws in the roads, perhaps you should tend to your job, marshal…"),
                ccb.content.text("You see anything you want, marshal?"),
                ccb.content.text("Oh, a U.S. marshal, how quaint."),
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
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ROBOFAC_FREE_MERCHANT",
        },
        {
            text = ccb.content.text("When is the next shipment?"),
            next_topic = "TALK_ROBOFAC_FREE_MERCHANT_INTERVAL",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_ROBOFAC_FREE_MERCHANT_DOING",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_FREE_MERCHANT_DOING",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("I keep to my own business, and you keep to yours, marshal.  Seems like a fair deal?"),
        no = ccb.content.text("We have been supplying this lab here with food from a few hunting and farming communities nearby.  The roads are tough and dangerous, but it makes good money, and beats scavenging the cities for scraps."),
    },
    replies = { { text = ccb.content.text("Keep safe, then."), next_topic = "TALK_ROBOFAC_FREE_MERCHANT" } },
}
