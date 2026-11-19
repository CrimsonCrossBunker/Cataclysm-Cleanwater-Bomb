local ccb = require("ccb")

ccb.content.define_spell {
    id = "iso_blackfire_blast",
    name = ccb.content.text("Blackfire"),
    description = ccb.content.text("Whatever powers this deep red fire is more fundamental than the simple breaking of chemical bonds."),
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "IGNORE_WALLS" },
    difficulty = 15,
    max_level = 2,
    effect = "attack",
    shape = "blast",
    min_range = 1,
    max_range = 12,
    damage_type = "pure",
    min_damage = 20000,
    max_damage = 20000,
    min_aoe = 2,
    aoe_increment = 48,
    max_aoe = 50,
    base_energy_cost = 1500,
    base_casting_time = 500,
}
