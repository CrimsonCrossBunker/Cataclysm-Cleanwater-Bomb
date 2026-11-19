local ccb = require("ccb")

ccb.content.define_item {
    id = "periapt_health",
    copy_from = "platinum_periapt_magic",
    name = ccb.content.plural_text("periapt of health", "periapts of health"),
    description = ccb.content.text("Previously a common means of displaying wealth through overpriced miscellany, these have now become invaluable after the Cataclysm, where even a single illness could severely endanger your life.  Does nothing against poison, and may not work on more esoteric diseases."),
    survival_price = "9000 USD",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_periapt_health_0" } },
}

ccb.content.define_item {
    id = "periapt_proof_against_poison",
    copy_from = "platinum_periapt_magic",
    name = ccb.content.plural_text("periapt of proof against poison", "periapts of proof against poison"),
    description = ccb.content.text("Useful in both the medieval era for traditional poisons and the modern day for allergies.  Does nothing against disease, and may not work on more esoteric poisons."),
    survival_price = "9000 USD",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_periapt_proof_against_poison_0" } },
}

ccb.content.define_item {
    id = "periapt_wound_closure",
    copy_from = "platinum_periapt_magic",
    name = ccb.content.plural_text("periapt of wound closure", "periapts of wound closure"),
    description = ccb.content.text("Standard issue at emergency rooms across the country, this is an item that grants preternatural skill at bandaging and disinfecting wounds.  Still takes some basic skill to use with maximum efficacy."),
    survival_price = "9000 USD",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_periapt_wound_closure_0" } },
}
