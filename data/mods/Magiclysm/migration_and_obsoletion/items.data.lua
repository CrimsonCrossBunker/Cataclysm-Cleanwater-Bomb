local ccb = require("ccb")

-- Remove after 0.J
ccb.content.define_item {
    id = "item_kelvinist_frozen_heart",
    name = ccb.content.plural_text("Rime-Frozen Heart", "Rime-Frozen Hearts"),
    description = ccb.content.text("You don't feel anything."),
    mass = "0 g",
    volume = "0 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = {
        "PERSONAL", "SEMITANGIBLE", "ZERO_WEIGHT", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF",
        "NONCONDUCTIVE", "PADDED", "INTEGRATED",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_item_kelvinist_frozen_heart_0" } },
}
