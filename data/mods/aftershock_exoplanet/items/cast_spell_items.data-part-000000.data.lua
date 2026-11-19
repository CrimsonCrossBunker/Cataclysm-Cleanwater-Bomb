local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_caster",
    abstract = true,
    name = ccb.content.text_without_extraction("caster"),
    description = ccb.content.text_without_extraction("A generic techno doodad used to cast spells."),
    mass = "100 g",
    volume = "250 ml",
    price = "50 USD",
    materials = { "superalloy" },
    symbol = "[",
    color = "light_red",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "NO_UNLOAD", "NO_RELOAD" },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1 },
    armor = { warmth = 0, portions = { { coverage = 0, covers = { "torso" } } } },
}
