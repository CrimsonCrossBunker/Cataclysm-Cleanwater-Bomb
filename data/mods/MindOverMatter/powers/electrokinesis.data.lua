local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_lightning_aura_spark",
    name = ccb.content.text_without_extraction("[Ψ]Galvanic Aura Sparks"),
    description = ccb.content.text_without_extraction("Galvanic Aura attacks.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ally" },
    skill = "metaphysics",
    flags = { "PSIONIC", "LOUD", "NO_EXPLOSION_SFX", "NO_HANDS", "NO_LEGS" },
    effect = "emit",
    effect_data = "emit_shock_cloud_big",
    shape = "blast",
    damage_type = "electric",
    max_level = { handler = "scale_electrokinetic_lightning_aura_spark_max_level", fallback = 0 },
}

-- Currently galvanic aura successfully calls this spell to attack enemies.  However, it does not 'draw a line' towards the enemy, merely spawning on top of them.  Still not fully functional.
-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_lightning_aura_attack_placeholder",
    name = ccb.content.text_without_extraction("[Ψ]Galvanic Aura Bolt"),
    description = ccb.content.text_without_extraction("Galvanic Aura attacks.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ally" },
    skill = "metaphysics",
    flags = { "SILENT", "NO_PROJECTILE", "RANDOM_DAMAGE", "RANDOM_CRITTER", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "line",
    damage_type = "electric",
    max_level = { handler = "scale_electrokinetic_lightning_aura_spark_max_level", fallback = 0 },
    min_damage = {
        handler = "scale_electrokinetic_lightning_aura_attack_placeholder_min_damage",
        fallback = 2.5,
    },
    max_damage = {
        handler = "scale_electrokinetic_lightning_aura_attack_placeholder_max_damage",
        fallback = 10.0,
    },
    min_range = {
        handler = "scale_electrokinetic_lightning_aura_attack_placeholder_min_range",
        fallback = 1.0,
    },
    max_range = 10,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 4,
    field_chance = 1,
}

ccb.content.define_spell {
    id = "electrokinetic_lightning_blast",
    name = ccb.content.text("[Ψ]Ion Blast"),
    description = ccb.content.text("Launch a blast of lightning at a nearby target, causing a secondary explosion at the location."),
    message = ccb.content.text("You unleash an explosive blast of lightning."),
    teachable = false,
    valid_targets = { "hostile", "ground", "ally" },
    spell_class = "ELECTROKINETIC",
    magic_type = "mom_psionics",
    skill = "metaphysics",
    flags = { "PSIONIC", "LOUD", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    difficulty = 9,
    max_level = { handler = "scale_electrokinetic_lightning_aura_spark_max_level", fallback = 0 },
    effect = "attack",
    extra_spells = { { spell = "electrokinetic_lightning_blast_trail", self = false } },
    shape = "blast",
    damage_type = "electric",
    min_damage = { handler = "scale_electrokinetic_lightning_blast_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_electrokinetic_lightning_blast_max_damage", fallback = 0.0 },
    min_range = { handler = "scale_electrokinetic_lightning_blast_min_range", fallback = 0.0 },
    max_range = 50,
    min_aoe = { handler = "scale_electrokinetic_lightning_blast_min_aoe", fallback = 0.0 },
    field = "fd_electricity",
    min_field_intensity = 3,
    max_field_intensity = 7,
    field_chance = 1,
    base_energy_cost = 8500,
    final_energy_cost = 4000,
    energy_increment = -100,
    base_casting_time = 150,
    final_casting_time = 65,
    casting_time_increment = -6,
    sound_type = "combat",
    sound_description = ccb.content.text("zzzzaaaaaapp!"),
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_lightning_blast_trail",
    name = ccb.content.text_without_extraction("[Ψ]Ion Blast Trail"),
    description = ccb.content.text_without_extraction("This causes the lightning bolt at the target location.  It's a bug if you have it directly."),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ground", "ally" },
    skill = "metaphysics",
    flags = { "PSIONIC", "LOUD", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    shape = "line",
    damage_type = "electric",
    min_damage = { handler = "scale_electrokinetic_lightning_blast_trail_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_electrokinetic_lightning_blast_trail_max_damage", fallback = 0.0 },
    min_range = { handler = "scale_electrokinetic_lightning_blast_trail_min_range", fallback = 0.0 },
    max_range = 50,
    min_aoe = { handler = "scale_electrokinetic_lightning_blast_trail_min_aoe", fallback = 0.0 },
    field = "fd_electricity",
    min_field_intensity = 3,
    max_field_intensity = 7,
    field_chance = 1,
}

ccb.content.define_spell {
    id = "electrokinetic_revive",
    name = ccb.content.text("[Ψ]Revivification"),
    description = ccb.content.text("Manipulate the nervous system of a corpse, causing it to rise and protect you.  This protection will only last a short time."),
    message = ccb.content.text("You charge a nearby corpse with lightning."),
    teachable = false,
    valid_targets = { "hostile", "ground", "ally" },
    spell_class = "ELECTROKINETIC",
    magic_type = "mom_psionics",
    skill = "metaphysics",
    flags = { "PSIONIC", "NO_HANDS", "NO_LEGS" },
    difficulty = 10,
    max_level = { handler = "scale_electrokinetic_lightning_aura_spark_max_level", fallback = 0 },
    effect = "revive",
    effect_data = "ZOMBIE",
    extra_spells = {
        { spell = "electrokinetic_revive_charm", self = false },
        { spell = "electrokinetic_revive_heal", self = false },
        { spell = "electrokinetic_revive_debuff", self = false },
    },
    shape = "blast",
    min_range = { handler = "scale_electrokinetic_revive_min_range", fallback = 0.0 },
    max_range = 50,
    base_energy_cost = 10000,
    final_energy_cost = 6000,
    energy_increment = -150,
    base_casting_time = 250,
    final_casting_time = 125,
    casting_time_increment = -6,
    ignored_species = { "PSI_NULL", "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
-- Long duration doesn't matter since the below spells will ensure the target dies
ccb.content.define_spell {
    id = "electrokinetic_revive_charm",
    name = ccb.content.text_without_extraction("[Ψ]Revive Charm"),
    description = ccb.content.text_without_extraction("This turns the revived monster to your side.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ground" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    effect = "charm_monster",
    shape = "blast",
    min_damage = 1500,
    max_damage = 1500,
    min_range = { handler = "scale_electrokinetic_revive_min_range", fallback = 0.0 },
    min_duration = 360000,
    max_duration = 360000,
    targeted_species = { "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_revive_heal",
    name = ccb.content.text_without_extraction("[Ψ]Revive Heal"),
    description = ccb.content.text_without_extraction("This heals the revivified target so it doesn't die basically immediately after rising.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ally" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_LEGS", "NO_HANDS", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    min_damage = -50,
    max_damage = -80,
    min_range = { handler = "scale_electrokinetic_revive_min_range", fallback = 0.0 },
    targeted_species = { "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_revive_debuff",
    name = ccb.content.text_without_extraction("[Ψ]Revive Debuff"),
    description = ccb.content.text_without_extraction("This puts a debuff on the revived monster that will make sure it eventually dies.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ally" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_electrokin_revive_debuff",
    shape = "blast",
    min_duration = 360000,
    max_duration = 360000,
    min_range = { handler = "scale_electrokinetic_revive_min_range", fallback = 0.0 },
    targeted_species = { "ZOMBIE" },
}
