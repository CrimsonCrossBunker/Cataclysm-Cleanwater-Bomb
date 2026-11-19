local ccb = require("ccb")

ccb.content.define_item {
    id = "thorns_electric",
    name = ccb.content.plural_text("aura of repelling arc", "auras of repelling arc"),
    description = ccb.content.text("An invisible aura that strikes melee attackers with arcs of electricity."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "blue",
    materials = { "magical_material" },
    flags = {
        "AURA",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "OVERSIZE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_thorns_electric_0" } },
}
