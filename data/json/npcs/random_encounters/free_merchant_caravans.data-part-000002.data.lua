local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_2",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Do you have anything to trade?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Story",
        },
        {
            text = ccb.content.text("Nothing much.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Threatening",
    line = ccb.content.text("No, not at all.  Just being cautious.  You know how it gets out here.  We're not looking for trouble.  In fact, if you've got anything worthwhile, maybe we could do a little trading."),
    replies = {
        {
            text = ccb.content.text("Sure, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What's your deal here?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Job",
        },
        {
            text = ccb.content.text("That suits me fine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Job",
    line = ccb.content.text("We're just travelers, making a pit stop.  Might be willing to trade a bit, if you've got anything to share.  We're not looking for trouble, there's plenty of that on the roads already."),
    replies = {
        {
            text = ccb.content.text("Sure, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("That's it?  What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Story",
        },
        {
            text = ccb.content.text("That suits me fine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
