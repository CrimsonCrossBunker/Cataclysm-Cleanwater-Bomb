local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "BEM_ANCHOR_SELLER_1", "BEM_ANCHOR_SELLER_ASK" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } }),
        yes = ccb.content.gendered_line("Sorry I'd rather be left alone right now.", { "interlocutor" }),
        no = ccb.content.gendered_line("&A grim expression and deep sunken eyes imply some malady that can't be simply drowned with alcohol alone.  They interrupt you just as you were about to introduce yourself.  \"This anchor I'm wearing, I don't think I'll be needing it any more.  I-I'm just looking for someone to rid me of it.\"", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Offer to buy the anchor for 1 HGC."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } })),
            next_topic = "BEM_ANCHOR_SELLER_2",
        },
        {
            text = ccb.content.text("Well, what's that thing for anyways?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } })),
            next_topic = "BEM_ANCHOR_SELLER_ASK",
        },
        {
            text = ccb.content.text("Sorry, I don't think I can help you."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } })),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Alright, see you around then."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal" } }),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_ANCHOR_SELLER_ASK",
    line = ccb.content.gendered_line("The mercenary stares in silence, a flickering of the overhead lighting thankfully cuts the moment short.", { "interlocutor" }),
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_ancilla_bar_remove_BEM_anchor_seller",
    layout = {
        npc_removals = { { id = "BEM_anchor_seller", x = 0, y = 0 } },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_ANCHOR_SELLER_2",
    line = ccb.content.gendered_line("It takes only a moment to retrieve a suitable coin from your pockets, and yet your interlocutor found enough time to disappear, having left a sharp emptiness both in memory and the chair before you.  The anchor has been neatly folded on the table.", { "interlocutor" }),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "dialogue_BEM_ANCHOR_SELLER_ANCHOR_SELLER_paranormal", "yes"), actions.handler("w16b_a_dda_10371ccaec0c") } },
    },
    replies = {
        {
            text = ccb.content.text("Take the anchor."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_48c301d35711") },
        },
        {
            text = ccb.content.text("Take the anchor and leave the coin.  Do we have a deal?"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 1),
            actions = { actions.transfer_items("RobofacCoin"), actions.handler("w16b_a_dda_48c301d35711") },
        },
        {
            text = ccb.content.text("Just leave, this isn't right at all."),
            next_topic = "TALK_DONE",
        },
    },
}
