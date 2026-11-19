local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "platinum_periapt_magic",
    abstract = true,
    name = ccb.content.text_without_extraction("platinum periapt"),
    description = ccb.content.text_without_extraction("A periapt with a large gem, subtly glowing from within."),
    mass = "50 g",
    volume = "15 ml",
    materials = { "platinum", "crystallized_mana" },
    symbol = "[",
    color = "white",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "BELTED", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { coverage = 0, covers = { "torso" }, subparts = { "torso_neck" } } } },
}
