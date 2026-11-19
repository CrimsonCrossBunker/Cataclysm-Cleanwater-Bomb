local ccb = require("ccb")

ccb.content.define_item {
    id = "copper_infuser",
    copy_from = "copper_bracelet",
    qualities = { { id = "MANA_INFUSE", level = 1 } },
    name = ccb.content.text("copper infusion bracelet"),
    description = ccb.content.text("This bracelet has runes engraved on it.  You sense a faint air of mysticism when you look at it.  It would be useful for imbuing mana into material."),
    armor = {},
}

ccb.content.define_item {
    id = "silver_infuser",
    copy_from = "silver_bracelet",
    qualities = { { id = "MANA_INFUSE", level = 2 } },
    name = ccb.content.text("silver infusion bracelet"),
    description = ccb.content.text("This bracelet has runes engraved on it.  You sense a faint air of mysticism when you look at it.  It would be useful for imbuing mana into material."),
    armor = {},
}
