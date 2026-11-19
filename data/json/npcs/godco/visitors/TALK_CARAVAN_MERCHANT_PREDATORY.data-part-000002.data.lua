local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Threatening",
    line = ccb.content.text("No, not at all.  Just being cautious.  You know how it gets out here.  We're not looking for trouble.  In fact, if you've got anything worthwhile, maybe we could do a little trading."),
    replies = {
        {
            text = ccb.content.text("Sure, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What's your deal here?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Job",
        },
        {
            text = ccb.content.text("That suits me fine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Job",
    line = ccb.content.gendered_line("I'm a businessman, and business is my game.  I came out here to help these poor, poor people who are doing without in such a bad time.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Sure, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("That's it?  What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Story",
        },
        {
            text = ccb.content.text("That suits me fine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Story",
    line = ccb.content.gendered_line("I'm just a man looking to help some poor folks out, caught word of this place from one of those old FEMA bunkers, a group's holed up there.  I figured I'd come out here and help these people out.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("That's interesting.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can you give me directions to any of these other survivor groups?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Others",
        },
        {
            text = ccb.content.text("Thanks for chatting.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Others",
    line = ccb.content.text("No offense, but my clients definitely would not like me giving strangers directions to their hideouts.  You'll have to find them on their own terms."),
    replies = {
        {
            text = ccb.content.text("I can understand that.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Thanks for chatting.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
