local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hedge_blessed_weapon_nether_damage",
    name = ccb.content.text_without_extraction("Blessed Weapon Nether Damage"),
    description = ccb.content.text_without_extraction("This is the extra damage a blessed weapon does to Nether creatures.  It's a bug if you have it directly."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    magic_type = "xe_hedge_magick",
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    min_damage = 5,
    max_damage = 25,
    min_range = 1,
    max_range = 1,
    targeted_species = { "NETHER", "ABERRATION", "HORROR", "NETHER_EMANATION" },
}
