local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "afs_telekinetic_force_shove_away",
    name = ccb.content.text_without_extraction("[Ψ]Force Shove Push Real"),
    description = ccb.content.text_without_extraction("The actual effect that causes the force shove away.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ally", "hostile" },
    spell_class = "AFS_TELEKINETIC",
    skill = "metaphysics",
    flags = { "PSIONIC", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    difficulty = 1,
    max_level = 30,
    effect = "directed_push",
    shape = "blast",
    min_damage = 0,
    max_damage = 30,
    damage_increment = 1,
    min_range = 50,
    max_range = 50,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "afs_telekinetic_force_shove_toward",
    name = ccb.content.text_without_extraction("[Ψ]Force Shove Pull Real"),
    description = ccb.content.text_without_extraction("The actual effect that causes the force shove toward.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ally", "hostile" },
    spell_class = "AFS_TELEKINETIC",
    skill = "metaphysics",
    flags = { "PSIONIC", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    difficulty = 1,
    max_level = 30,
    effect = "directed_push",
    shape = "blast",
    min_damage = 0,
    max_damage = -30,
    damage_increment = -1,
    min_range = 50,
    max_range = 50,
}
