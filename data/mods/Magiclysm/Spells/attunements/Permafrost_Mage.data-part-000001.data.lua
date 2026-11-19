local ccb = require("ccb")

-- dirty hack till emit spell would be fixed
ccb.content.define_item {
    id = "aura_cold_energy",
    name = ccb.content.plural_text("Ice Orbit", "Ice Orbits"),
    description = ccb.content.text("Small particles of ice orbit around your body, as a beacon for a giant field of frozen energy."),
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
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_aura_cold_energy_0" } },
}
