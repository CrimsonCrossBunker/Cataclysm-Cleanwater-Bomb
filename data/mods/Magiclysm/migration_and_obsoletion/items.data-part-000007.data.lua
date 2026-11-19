local ccb = require("ccb")

-- Remove after 0.J
ccb.content.define_item {
    id = "magic_light",
    category = "tools",
    name = ccb.content.text("magic light"),
    description = ccb.content.text("A small magical light that you can read by."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    symbol = ",",
    color = "light_green",
    materials = { "magical_material" },
    light = 8,
    flags = { "AURA", "SEMITANGIBLE", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS" },
    armor = { portions = { { covers = { "head" } } } },
}

-- Remove after 0.J
ccb.content.define_item {
    id = "druid_fertilizer",
    name = ccb.content.plural_text("seed of growth", "seed of growth"),
    mass = "27 g",
    color = "white",
    flags = { "TRADER_AVOID", "FERTILIZER" },
    symbol = "°",
    description = ccb.content.text("A magical powder that can be scattered on growing crops to make them grow faster."),
    materials = { "powder" },
    volume = "33 ml",
    category = "chems",
    comestible = { kind = "FOOD", quench = -10, healthy = -2, fun = -15 },
}
