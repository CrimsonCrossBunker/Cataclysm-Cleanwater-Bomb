local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "NC_SALVOR_STREET_FOOD", "NC_SALVOR_STREET_FOOD_SAFE" },
    line = ccb.content.text("&The food stall is a colorful array of various dishes, and the smell of spices and cooked meats cuts easily through the frozen air.  The vendor  is busy preparing a meal when you approach.\n\"Oh steemd do you see anything you like?\""),
    replies = {
        {
            text = ccb.content.text("I'll have whatever it is you're cooking."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Are these things safe to eat?"),
            next_topic = "NC_SALVOR_STREET_FOOD_SAFE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_SALVOR_STREET_FOOD_SAFE" },
    line = ccb.content.text("&The vendor chuckles at your question, wiping his hands on his apron.\n\"Safe?  Yes, very safe steemd, snow dry and clean steemd.  In home we do not have so much snow, but here it is very good for food.\""),
}
