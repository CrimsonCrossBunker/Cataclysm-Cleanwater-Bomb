local ccb = require("ccb")

-- 'plant_sac' should probably be migrated to something like 'fungal_sac' at some point, but it's low priority.
ccb.content.define_item {
    id = "plant_sac",
    name = ccb.content.plural_text("fungal fluid sac", "fungal fluid sacs"),
    category = "other",
    mass = "270 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A fluid bladder from a fungus-based lifeform.  The membrane is tough and nearly indigestible.  It doesn't seem to contain anything deliberately toxic to you, but the alien biology and sharp, earthy, rotting scent suggests it still wouldn't be wise to ingest regardless of the fluid's purpose to its original owner."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "FUNGAL_VECTOR" },
    comestible = { shelf_life = "3 days 8 hours", kind = "FOOD", quench = 18, calories = 35, fun = -10 },
    use_actions = { "POISON" },
}
