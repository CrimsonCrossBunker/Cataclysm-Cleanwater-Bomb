local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



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
