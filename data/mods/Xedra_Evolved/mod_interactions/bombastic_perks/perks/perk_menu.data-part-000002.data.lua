local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_MAIN",
    replies = {
        {
            when = predicates.all({ predicates.has_trait("speaker", "perk_ALCHEMY1"), predicates.negate(predicates.has_trait("speaker", "perk_ALCHEMY2")) }),
            text = ccb.content.text("Gain [<trait_name:perk_ALCHEMY2>]"),
            next_topic = "TALK_PERK_MENU_ALCHEMY2",
        },
    },
}
