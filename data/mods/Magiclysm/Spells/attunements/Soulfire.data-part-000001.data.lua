local ccb = require("ccb")

-- NO_I18N
ccb.content.define_spell {
    id = "soul_afterburner_cooldown_backlash",
    name = ccb.content.text("Soul backlash"),
    description = ccb.content.text_without_extraction("This is a description for a spell the player will never see."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    min_damage = 30,
    max_damage = 30,
    damage_increment = 1.5,
    damage_type = "pure",
    shape = "blast",
    effect = "attack",
}
