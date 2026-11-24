local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "BEM_TEMPLATE_SELLER_1", "BEM_TEMPLATE_SELLER_ASK" },
    line = ccb.content.gendered_line("&The mercenary seems uncharacteristically upbeat, or perhaps just drunk.  \"Found this neat gizmo in a lab run a few days ago.\"  <mypronoun> blurts while procuring a small cube of etched glass from <mypossesivepronoun> pocket.  \"Now, I have no use for such a thing, but perhaps you do.  What do you say?  It's yours for 3 coins.\"", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[3 HGC] It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 3),
            actions = { actions.transfer_items("RobofacCoin", 3), actions.handler("dlg_a_dda_02f789c7714b"), "end_conversation" },
        },
        {
            text = ccb.content.text("Offer to buy it for 2 coins."),
            when = predicates.handler("dlg_p_dda_86c977e8ade1"),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "BEM_TEMPLATE_SELLER_DISCOUNT_BUY" },
            failure = { next_topic = "BEM_TEMPLATE_SELLER_NO_DEAL" },
        },
        {
            text = ccb.content.text("I don't even know what that is."),
            next_topic = "BEM_TEMPLATE_SELLER_ASK",
        },
        {
            text = ccb.content.text("Sorry, not interested."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_TEMPLATE_SELLER_DISCOUNT_BUY",
    line = ccb.content.text("Sure whatever, two coins and it's all yours."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialog_negotiated", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[2 HGC] It's a deal then."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 2),
            actions = { actions.transfer_items("RobofacCoin", 2), actions.handler("dlg_a_dda_02f789c7714b"), "end_conversation" },
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
    id = "BEM_TEMPLATE_SELLER_ASK",
    line = ccb.content.text("A 'nanofabricator template', it seems, no idea what it's good for, but it sure looks valuable.  Are you buying it or not?"),
}

ccb.content.define_dialogue_topic {
    id = "BEM_TEMPLATE_SELLER_NO_DEAL",
    line = ccb.content.text("Well I'm sure someone who values it will come around, thanks for hearing the pitch anyways."),
    on_enter = { { actions = { actions.set_actor_value("interlocutor", "dialog_negotiated", "yes") } } },
    replies = {
        {
            text = ccb.content.text("See you around then."),
            actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}
