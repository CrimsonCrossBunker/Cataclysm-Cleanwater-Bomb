local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_drunken_master",
    name = ccb.content.plural_text("Drunken Master aura", "Drunken Master auras"),
    description = ccb.content.text("Hey I thought this was America…"),
    mass = "1 g",
    volume = "1 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "dreamstuff" },
    flags = { "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_drunken_master_0" } },
}
