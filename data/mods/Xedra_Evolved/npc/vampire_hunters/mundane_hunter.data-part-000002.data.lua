local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE_TRADE",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_0a508fa5baff"),
            yes = ccb.content.text("I have plenty of leather and bone to sell but nothing edible to spare.  We must maintain our food stockpile for when it will be scarce."),
            no = ccb.content.text("I have plenty of leather and bone to sell and I can give you some jerky if you want."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll buy."),
            next_topic = "TALK_HUNTER_MUNDANE",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'd take some jerky."),
            next_topic = "TALK_HUNTER_MUNDANE_GIVE_JERKY",
            when = predicates.handler("dlg_p_xedra_evolved_fa2c90835cf0"),
            actions = { actions.handler("dlg_a_xedra_evolved_d4fff8570f2a") },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Maybe later.  Bye!"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE_TRAIN",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_xedra_evolved_0a508fa5baff"),
            yes = ccb.content.text("You helped us, so I'll give you a good discount for your training."),
            no = ccb.content.text("If you want that, you'll have to pay for it.  I won't stop gathering food just to train a stranger."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("I can pay."),
            next_topic = "TALK_TRAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5c3b94c5290a"),
        },
        {
            text = ccb.content.text("Thanks!  Let's start the training."),
            next_topic = "TALK_TRAIN",
            when = predicates.handler("dlg_p_xedra_evolved_fa2c90835cf0"),
            actions = { actions.handler("dlg_a_xedra_evolved_26f5e04b6fdb") },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Maybe later.  Bye!"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE_GIVE_JERKY",
    line = {
        choices = {
            ccb.content.text("Here's some jerky.  It's not something we sell, but you brought some badly-needed help so you can have it."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'd take more jerky."),
            next_topic = "TALK_HUNTER_MUNDANE_GIVE_JERKY",
            when = predicates.handler("dlg_p_xedra_evolved_fa2c90835cf0"),
            actions = { actions.handler("dlg_a_xedra_evolved_d4fff8570f2a") },
        },
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_HUNTER_MUNDANE",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Maybe later.  Bye!"),
            next_topic = "TALK_DONE",
        },
    },
}
