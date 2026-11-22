local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "BEM_KEYCARD_SELLER_1", "BEM_KEYCARD_SELLER_ASK" },
    line = ccb.content.text("&You spot the mercenary at the tail end of a deal.  \"Want in on the business?  Still have a pair of ID cards looking for buyers.  Two army and two science cards left, they sell together for 4 coins or not at all.\""),
    replies = {
        {
            text = ccb.content.text("[4 HGC] Its a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 4),
            actions = { actions.transfer_items("RobofacCoin", 4), actions.handler("dlg_a_dda_18cd15f0e566"), "end_conversation" },
        },
        {
            text = ccb.content.text("Offer to buy them for 2 coins."),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_KEYCARD_SELLER_DISCOUNT_BUY" },
            failure = { next_topic = "TALK_KEYCARD_SELLER_NO_DISCOUNTS" },
        },
        {
            text = ccb.content.text("Huh, where did you get those from?"),
            next_topic = "BEM_KEYCARD_SELLER_ASK",
        },
        {
            text = ccb.content.text("Sorry, not interested."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KEYCARD_SELLER_DISCOUNT_BUY",
    line = ccb.content.text("Sure whatever, two coins and it's all yours."),
    replies = {
        {
            text = ccb.content.text("[2 HGC] It's a deal then."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 2),
            actions = { actions.transfer_items("RobofacCoin", 2), actions.handler("dlg_a_dda_18cd15f0e566"), "end_conversation" },
        },
        {
            text = ccb.content.text("Oh, it looks like I don't actually have two coins right now…"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_inventory("speaker", "RobofacCoin", 2)),
        },
        {
            text = ccb.content.text("See you around then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_KEYCARD_SELLER_ASK",
    line = ccb.content.text("Well that'd be telling.  Suffice to say that a few friends found them, and none of us are into the lab-dive business."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_KEYCARD_SELLER_NO_DISCOUNTS",
    line = ccb.content.text("Not a bargain bin kid, the price's the price."),
    replies = {
        {
            text = ccb.content.text("See you around then."),
            native_actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}
