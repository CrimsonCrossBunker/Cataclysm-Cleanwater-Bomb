local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_MAIN",
    replies = {
        {
            when = predicates.negate(predicates.has_trait("speaker", "perk_LOW_INT_MANA")),
            text = ccb.content.text("Gain [<trait_name:perk_LOW_INT_MANA>]"),
            next_topic = "TALK_PERK_MENU_LOW_INT_MANA",
        },
    },
}
