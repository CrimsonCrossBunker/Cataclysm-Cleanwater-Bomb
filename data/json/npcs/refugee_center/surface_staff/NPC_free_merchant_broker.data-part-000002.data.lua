local ccb = require("ccb")

ccb.content.define_dialogue_topic { id = "TALK_FREE_MERCHANT_STOCKS", line = ccb.content.text("What can I help you with?") }

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_DELIVER",
    line = ccb.content.text("Excellent.  What've you brought us?"),
    repeat_replies = {
        {
            items = {
                "jerky", "meat_smoked", "fish_smoked", "dry_meat", "dry_veggy", "dry_fruit",
                "cooking_oil", "cornmeal", "flour", "fruit_wine", "beer", "sugar", "salt", "vinegar",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_JARS",
    line = ccb.content.text("Yes, I can buy 500 mL or 3 L glass jars at the moment."),
    repeat_replies = {
        {
            items = { "jar_glass_sealed", "jar_3l_glass_sealed" },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_NEW",
    line = ccb.content.gendered_line("I oversee the food stocks for the center.  There was significant looting during the panic when we first arrived so most of our food was carried away.  I manage what we have left and do everything I can to increase our supplies.  We've got a few growing sources of fresh meats and vegetables, so I prioritize non-perishable food, such as cornmeal, jerky, and fruit wine.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why cornmeal, jerky, and fruit wine?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_WHY",
        },
        {
            text = ccb.content.text("Okay, but I meant \"who are you\", like, \"what's your story?\""),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_BACKGROUND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_WHY",
    line = ccb.content.text("All three are easy to locally produce in significant quantities and are non-perishable.  We have a local farmer or two and a few hunter types that have been making attempts to provide us with the nutritious supplies.  We do always need more suppliers though.  This stuff is rather cheap in bulk, so I can pay a premium for any you have on you.  Canned food and other edibles are handled by the merchant in the front in trade."),
    replies = {
        {
            text = ccb.content.text("Are you looking to buy anything else?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_ALL",
        },
        {
            text = ccb.content.text("Very well… let's talk about something else."),
            next_topic = "TALK_FREE_MERCHANT_STOCKS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_BACKGROUND",
    line = ccb.content.text("I'm sorry, but I'm not here to make friends, I've got a job to do."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_ALL",
    line = ccb.content.text("I'm actually accepting a number of different foodstuffs: beer, sugar, flour, smoked meat, smoked fish, dried fruit and vegetables, cooking oil, preservatives like salt and vinegar; and as mentioned before, jerky, cornmeal, and fruit wine."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_FMCN",
    line = ccb.content.text("We call them \"Free Merchant Certified Notes\".  We started signing money almost as soon as we got here as a way of showing it represented actual goods and services we had to trade.  Within a few days we'd organized the system, and now it's been evolving into a form of cash.  Internally they're traded for labor and services in exchange for food rations and other trade goods, but we've been using them with suppliers we regularly trade with as well, those that have faith in us."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_REFUGEES",
    line = ccb.content.text("Yeah, it's a tough situation.  When we started out here nobody was really in charge, and we let more in than we really had capacity to feed and support.  When the dust settled and we'd established a little order, there were still all these people upstairs waiting for a place to live, and no space.  We've set up a little space for them, but it's not ideal."),
}
