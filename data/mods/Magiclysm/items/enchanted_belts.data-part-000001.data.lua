local ccb = require("ccb")

ccb.content.define_item {
    id = "mbelt_haste",
    copy_from = "mbelt_leather",
    name = ccb.content.plural_text("Belt of Haste", "Belts of Haste"),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mbelt_haste_0" } },
}

ccb.content.define_item {
    id = "mbelt_thor",
    copy_from = "mbelt_leather",
    name = ccb.content.plural_text("Megingjörð", "Megingjörð"),
    survival_price = "9500 USD",
    description = ccb.content.text("The mythical belt of Thor, god of thunder.  Or at least so it appears.  It doubles the wearer's base strength."),
    materials = { "superalloy" },
    inheritance = { add = { flags = { "PADDED" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = { thickness = 10, environmental_protection = 20 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mbelt_thor_0" } },
}
