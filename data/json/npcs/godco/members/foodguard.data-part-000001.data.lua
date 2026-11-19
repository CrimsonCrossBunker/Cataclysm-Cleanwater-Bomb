local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_borrow",
    line = {
        choices = {
            ccb.content.text("Nope, you can't do that.  I'd like to help you, but we've already got enough mouths to feed."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Could some money persuade you?"),
            trial = { kind = "persuade", difficulty = 10 },
            failure = { next_topic = "TALK_GODCO_guard_food_bribe_fail", opinion = { trust = -2 } },
            success = { next_topic = "TALK_GODCO_guard_food_bribe_success" },
        },
        {
            text = ccb.content.text("I can give these people one less mouth to feed, if you'd prefer that."),
            trial = { kind = "intimidate", difficulty = 10 },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
            success = { next_topic = "TALK_GODCO_guard_food_intimidate_success", opinion = { trust = -4 } },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food",
        },
        { text = ccb.content.text("Alright.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_theft",
    line = {
        choices = {
            ccb.content.text("Nobody's tried to yet.  It can get a little boring sometimes, standing around and doing nothing."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can understand that.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food",
        },
        {
            text = ccb.content.text("I hope it isn't too boring.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_stock",
    line = { choices = { ccb.content.text("That's private info, <name_g>.") } },
    replies = {
        { text = ccb.content.text("Okay."), next_topic = "TALK_GODCO_guard_food" },
        { text = ccb.content.text("Alright.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}
