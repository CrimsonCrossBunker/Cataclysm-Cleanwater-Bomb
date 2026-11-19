local ccb = require("ccb")

ccb.content.define_item {
    id = "overcharge_burn_scar",
    name = ccb.content.plural_text("overcharge burn", "overcharge burns"),
    description = ccb.content.text("Ouch, this really smarts!  It'll go away soon, maybe?"),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "~",
    color = "light_red",
    materials = { "magical_material" },
    flags = { "NO_TAKEOFF", "TRADER_AVOID", "BLIND" },
    subtype_order = { "armor", "artifact" },
    armor = { portions = { { encumbrance = 18, covers = { "eyes", "mouth" } } } },
    artifact = { enchantments = { "ench_overcharge_burn_scar" } },
}
