local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_explosion_trap_spell_activated",
    name = ccb.content.text_without_extraction("Salamander Trap Explosion"),
    description = ccb.content.text_without_extraction("This is the AoE used by Sigil of Detonation.  It's a bug if you have it directly."),
    message = "",
    valid_targets = { "hostile", "ground", "ally" },
    skill = "deduction",
    flags = {
        "LOUD",
        "NO_PROJECTILE",
        "IGNITE_FLAMMABLE",
        "RANDOM_AOE",
        "RANDOM_DAMAGE",
        "NO_HANDS",
        "NO_LEGS",
    },
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
    min_damage = 20,
    max_damage = 70,
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    field = "fd_fire",
    min_field_intensity = 1,
    max_field_intensity = 2,
    field_chance = 2,
    sound_type = "combat",
    sound_description = ccb.content.text("a crackle!"),
}
