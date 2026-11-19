local ccb = require("ccb")

-- Kamea is Hebrew for amulet
ccb.content.define_item {
    id = "item_hedge_raziel_amulet_protection",
    copy_from = "copper_necklace",
    looks_like = "copper_necklace",
    name = ccb.content.plural_text("Kamea of Protection", "Kameas of Protection"),
    description = ccb.content.text("A copper amulet, engraved with the names of angels and some of the secret names of God.  According to the text of the Sefer Raziel, wearing it will protect you from harm."),
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE", "HEDGE_ENCHANTED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_raziel_amulet_protection_0" } },
}

-- Kamea is Hebrew for amulet
ccb.content.define_item {
    id = "item_hedge_raziel_amulet_protection_done",
    copy_from = "copper_necklace",
    looks_like = "copper_necklace",
    name = ccb.content.plural_text("Kamea of Protection (scratched)", "Kameas of Protection (scratched)"),
    description = ccb.content.text("A copper amulet, engraved with the names of angels and some of the secret names of God.  According to the text of the Sefer Raziel, wearing it will protect you from harm.  Some of the text on the amulet is scratched."),
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = {},
}
