local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_power_draining_electric_monster",
    name = ccb.content.text_without_extraction("[Ψ]Electrokinetic Power Draining monster attack"),
    description = ccb.content.text_without_extraction("Gremlin's power to damage electric monsters.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    max_level = 1,
    min_damage = 10,
    max_damage = 55,
}
