local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dreadlord_heal",
    name = ccb.content.text_without_extraction("Dreadlord Heal"),
    description = ccb.content.text_without_extraction("Heals zombie dreadlord and nearby allies."),
    valid_targets = { "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_damage = -10,
    max_damage = -15,
    min_aoe = 12,
    max_aoe = 12,
    min_range = 2,
    max_range = 6,
    field = "fd_biolum",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
}
