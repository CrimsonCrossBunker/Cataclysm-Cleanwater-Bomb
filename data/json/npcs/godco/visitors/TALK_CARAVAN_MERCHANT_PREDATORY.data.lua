local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_1",
    line = ccb.content.text("Well well well, another traveler.  Don't try anything suspicious, you're outnumbered here and we're well armed, and my boss will know what happens soon enough."),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_MERCHANT_PREDATORY_2") } } },
    replies = {
        {
            text = ccb.content.text("Are you threatening me?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Threatening",
        },
        {
            text = ccb.content.text("What's your deal here?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Job",
        },
        {
            text = ccb.content.text("I won't try anything if you don't.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_2",
    line = ccb.content.text("What can I do for you, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Do you have anything to trade?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Your prices seem awfully high."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Price",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_paidoff" } })),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Story",
        },
        {
            text = ccb.content.text("Nothing much.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
    line = ccb.content.text("Heh, always good to do business."),
    replies = {
        {
            text = ccb.content.text("Actually, I had a little more to trade still."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("You got anything else?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_askinterval",
        },
        {
            text = ccb.content.text("Your prices seem awfully high."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Price",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_paidoff" } })),
        },
        {
            text = ccb.content.text("Thanks.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks for that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_askinterval",
    line = ccb.content.text("Well, not right now.  Try again after around <restock_time_point>."),
    replies = {
        {
            text = ccb.content.text("Okay.  About other things…"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Price",
    line = ccb.content.gendered_line("Like I said, I'm a businessman and business is my job.  Those other yahoos you've been talkin' to don't know what they're doing.", { "interlocutor" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_trade_u_think_suspicious_price", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Alright.  I'd like to buy something."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I think you're full of shit.  I know you're gouging for your own benefit, and wouldn't it be a shame if this information were to get out?"),
            trial = {
                kind = "persuade",
                difficulty = 5,
                modifiers = { { score = "INTIMIDATE", scale = 4 } },
            },
            success = { next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Win" },
            failure = { next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Lose" },
        },
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Win",
    line = ccb.content.text("Woah woah woah, cool your jets.  I can't let this spread about me, so name your price and keep quiet, and I might give you a discount."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "general_meeting_u_paidoff", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("50 merch and you have a deal."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_2effb650b682") },
        },
        {
            text = ccb.content.text("You know what, I don't want your <freaking> dirty money.  Go fuck yourself."),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Lose",
    line = ccb.content.text("What proof do you have <name_b>?  Nothing is what you got, and your the only one here who's full of shit."),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_MERCHANT_PREDATORY_NoTalk") } } },
    replies = {
        {
            text = ccb.content.text("If you don't wanna cooperate, I'll stop this by force."),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_NoTalk",
    line = ccb.content.text("Get out of here, <name_b>."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_DONE" } },
}
