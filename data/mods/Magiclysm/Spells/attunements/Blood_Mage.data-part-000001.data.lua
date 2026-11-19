local ccb = require("ccb")

ccb.content.define_item {
    id = "demon_possession_aura",
    name = ccb.content.plural_text("Ixythyug the Destroyer's soul", "Ixythyug the Destroyer's souls"),
    description = ccb.content.text("RIP AND TEAR"),
    mass = "1 g",
    volume = "1 ml",
    symbol = "o",
    color = "white",
    flags = { "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_demon_possession_aura_0" } },
}
