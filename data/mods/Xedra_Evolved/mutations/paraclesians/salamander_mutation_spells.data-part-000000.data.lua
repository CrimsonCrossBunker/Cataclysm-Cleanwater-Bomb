local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_aoe_explosion",
    name = ccb.content.text_without_extraction("Salamander AoE Explosion"),
    description = ccb.content.text_without_extraction("This is the AoE used by some other Salamander spells.  It's a bug if you have it directly."),
    message = "",
    valid_targets = { "hostile", "ground", "ally" },
    skill = "deduction",
    flags = { "LOUD", "NO_PROJECTILE", "IGNITE_FLAMMABLE", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
    max_level = 20,
    min_damage = 10,
    max_damage = 40,
    min_aoe = 1,
    max_aoe = 10,
    aoe_increment = 1,
    field = "fd_fire",
    min_field_intensity = 1,
    max_field_intensity = 2,
    field_chance = 2,
    sound_type = "combat",
    sound_description = ccb.content.text("a crackle!"),
}
