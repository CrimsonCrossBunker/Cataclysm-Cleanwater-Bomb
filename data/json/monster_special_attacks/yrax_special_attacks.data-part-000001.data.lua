local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "quadraphract_hurt_self",
    name = ccb.content.text_without_extraction("Wretch Hurt Self"),
    description = ccb.content.text_without_extraction("Hurts yourself."),
    flags = { "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 1200,
    max_damage = 1500,
    damage_type = "pure",
    valid_targets = { "hostile", "ally", "self", "ground" },
    shape = "blast",
    effect = "attack",
}
