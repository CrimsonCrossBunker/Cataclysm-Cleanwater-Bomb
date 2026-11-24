local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_banish_monster",
    name = ccb.content.text_without_extraction("[Ψ]Nether Banish Monster"),
    description = ccb.content.text_without_extraction("A spell for the zombie null to try to banish nether monsters.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "hostile" },
    targeted_species = { "NETHER" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    effect = "banishment",
    shape = "blast",
    min_damage = 100,
    max_damage = 600,
    min_range = 10,
    max_range = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_banish_monster_greater",
    name = ccb.content.text_without_extraction("[Ψ]Greater Nether Banish Monster"),
    description = ccb.content.text_without_extraction("A spell for the nether-void to try to banish nether monsters.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "hostile" },
    targeted_species = { "NETHER", "NETHER_EMANATION", "NETHER_BURROWING" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    effect = "banishment",
    shape = "blast",
    min_damage = 300,
    max_damage = 1000,
    min_range = 10,
    max_range = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_physical_enhancement_monster",
    name = ccb.content.text_without_extraction("Physical Enhancement Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Physical Enhancement when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "biokinetic_physical_enhancement_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_physical_enhancement_monster_self",
    name = ccb.content.text_without_extraction("Physical Enhancement Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Physical Enhancement to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_physical_enhancement",
    shape = "blast",
    min_duration = 18000,
    max_duration = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_physical_enhancement_improved_monster",
    name = ccb.content.text_without_extraction("Physical Enhancement Monster Improved enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Physical Enhancement but better when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "biokinetic_physical_enhancement_improved_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_physical_enhancement_improved_monster_self",
    name = ccb.content.text_without_extraction("Physical Enhancement Improved Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Physical Enhancement Improved to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_physical_enhancement_improved",
    shape = "blast",
    min_duration = 26000,
    max_duration = 49000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_speed_boost_monster_01",
    name = ccb.content.text_without_extraction("[Ψ]Biokinetic Speed Boost Monster Lesser"),
    description = ccb.content.text_without_extraction("Cause a monster to get a small number of extra moves.  It's a bug if you have this."),
    valid_targets = { "self" },
    flags = { "RANDOM_DAMAGE" },
    effect = "mod_moves",
    shape = "blast",
    min_damage = 150,
    max_damage = 350,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_hardened_skin_monster",
    name = ccb.content.text_without_extraction("Hardened Skin Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Hardened Skin when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "biokinetic_hardened_skin_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "biokinetic_hardened_skin_monster_self",
    name = ccb.content.text_without_extraction("Hardened Skin Monster Effect"),
    description = ccb.content.text_without_extraction("Grants hardened skin to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_hardened_skin",
    shape = "blast",
    min_duration = 9000,
    max_duration = 27000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pattern_screamer_rock_thrower_prep",
    name = ccb.content.text_without_extraction("Feral One Perfect Shot"),
    teachable = false,
    description = ccb.content.text_without_extraction("Pattern screamer prepares to hurl a rock with deadly accuracy"),
    flags = { "NO_HANDS", "NO_LEGS" },
    valid_targets = { "hostile" },
    max_level = 40,
    effect = "attack",
    shape = "blast",
    min_range = 8,
    max_range = 8,
    range_increment = 0.1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_heightened_senses_monster_1",
    name = ccb.content.text_without_extraction("Heightened Senses Tier 1 Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Heightened Senses to a clairsentient feral."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_heightened_senses",
    shape = "blast",
    min_duration = 18000,
    max_duration = 54000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_heightened_senses_monster_2",
    name = ccb.content.text_without_extraction("Heightened Senses Tier 2 Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Heightened Senses to a clairsentient feral."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_heightened_senses_2",
    shape = "blast",
    min_duration = 36000,
    max_duration = 108000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_heightened_senses_monster_3",
    name = ccb.content.text_without_extraction("Heightened Senses Tier 3 Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Heightened Senses to a clairsentient feral."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_heightened_senses_3",
    shape = "blast",
    min_duration = 72000,
    max_duration = 216000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_combat_sense_monster_2",
    name = ccb.content.text_without_extraction("Combat Sense Tier 2 Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Combat Sense to a clairsentient feral."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_combat_sense_2",
    shape = "blast",
    min_duration = 18000,
    max_duration = 54000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_combat_sense_monster_3",
    name = ccb.content.text_without_extraction("Combat Sense Tier 3 Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Combat Sense to a clairsentient feral."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_feral_combat_sense_3",
    shape = "blast",
    min_duration = 18000,
    max_duration = 54000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "clair_clarity_monster_spell",
    name = ccb.content.text_without_extraction("Heightened Clarity Monster Effect"),
    description = ccb.content.text_without_extraction("Grants Heightened Senses to a clairsentient feral."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_clair_clear_sight",
    shape = "blast",
    min_duration = 36000,
    max_duration = 108000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pattern_screamer_rock_thrower_prep_self",
    name = ccb.content.text_without_extraction("One Perfect Shot Self"),
    teachable = false,
    description = ccb.content.text_without_extraction("Grants the effect for a pattern screamer to throw a rock."),
    flags = { "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_pattern_screamer_rock_thrower",
    shape = "blast",
    min_duration = 100,
    max_duration = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_shock_touch_monster",
    name = ccb.content.text_without_extraction("[Ψ]Static Touch Monster"),
    description = ccb.content.text_without_extraction("Unleash a shock when touching a target, doing a small amount of damage and dazing them."),
    message = "",
    teachable = false,
    valid_targets = { "hostile", "ground", "ally" },
    flags = { "PSIONIC", "CONCENTRATE", "RANDOM_DAMAGE", "RANDOM_DURATION", "TOUCH_REQUIRED", "NO_LEGS" },
    difficulty = 1,
    max_level = 15,
    effect = "attack",
    effect_data = "psi_dazed_zap",
    shape = "blast",
    damage_type = "electric",
    min_damage = 3,
    max_damage = 7,
    min_range = 1,
    max_range = 1,
    min_duration = 100,
    max_duration = 400,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 2,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_lightning_bolt_monster",
    name = ccb.content.text_without_extraction("[Ψ]Electrocutioner Monster"),
    description = ccb.content.text_without_extraction("Launch a bolt of lightning at a nearby target."),
    message = "",
    valid_targets = { "hostile", "ground", "ally" },
    flags = { "PSIONIC", "CONCENTRATE", "LOUD", "RANDOM_DAMAGE", "SPLIT_DAMAGE", "NO_HANDS", "NO_LEGS" },
    max_level = 20,
    effect = "attack",
    shape = "line",
    damage_type = "electric",
    min_damage = 20,
    max_damage = 80,
    min_range = 4,
    max_range = 20,
    range_increment = 1,
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 2,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_lightning_blast_monster",
    name = ccb.content.text_without_extraction("[Ψ]Ion Blast Monster"),
    description = ccb.content.text_without_extraction("Launch a lightning explosion at a nearby target."),
    message = "",
    valid_targets = { "hostile", "ground", "ally" },
    flags = { "PSIONIC", "CONCENTRATE", "LOUD", "RANDOM_DAMAGE", "NO_HANDS", "SPLIT_DAMAGE", "NO_LEGS" },
    extra_spells = { { spell = "electrokinetic_lightning_blast_monster_emit", self = false } },
    max_level = 20,
    effect = "attack",
    shape = "line",
    damage_type = "electric",
    min_damage = 6,
    max_damage = 18,
    min_range = 4,
    max_range = 20,
    range_increment = 1,
    field = "fd_electricity",
    min_field_intensity = 5,
    max_field_intensity = 8,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_lightning_blast_monster_emit",
    name = ccb.content.text_without_extraction("[Ψ]Ion Blast Monster Emit"),
    description = ccb.content.text_without_extraction("Cause a burst of sparks near a target.  It's a bug if you see this."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile", "ally" },
    flags = { "PSIONIC", "NO_PROJECTILE", "LOUD", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    max_level = 20,
    effect = "emit",
    effect_data = "emit_shock_cloud",
    shape = "blast",
    damage_type = "electric",
    min_range = 4,
    max_range = 20,
    range_increment = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_revive_monster",
    name = ccb.content.text_without_extraction("[Ψ]Revivification Monster"),
    description = ccb.content.text_without_extraction("Manipulate the nervous system of a corpse, causing it to rise and protect you.  This protection will only last a short time."),
    message = "",
    teachable = false,
    valid_targets = { "ally", "ground" },
    flags = { "PSIONIC", "CONCENTRATE", "NO_HANDS", "NO_LEGS" },
    max_level = 20,
    effect = "revive",
    effect_data = "ZOMBIE",
    extra_spells = {
        { spell = "electrokinetic_revive_heal_monster", self = false },
        { spell = "electrokinetic_revive_debuff_monster", self = false },
    },
    shape = "blast",
    min_aoe = 1,
    max_aoe = 1,
    ignored_species = { "PSI_NULL", "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_revive_heal_monster",
    name = ccb.content.text_without_extraction("[Ψ]Revive Heal Monster"),
    description = ccb.content.text_without_extraction("This heals the revivified target so it doesn't die basically immediately after rising.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ally" },
    flags = { "PSIONIC", "SILENT", "NO_LEGS", "NO_HANDS", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    max_level = 20,
    effect = "attack",
    shape = "blast",
    min_damage = -50,
    max_damage = -80,
    min_aoe = 1,
    max_aoe = 1,
    targeted_species = { "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokinetic_revive_debuff_monster",
    name = ccb.content.text_without_extraction("[Ψ]Revive Debuff Monster"),
    description = ccb.content.text_without_extraction("This puts a debuff on the revived monster that will make sure it eventually dies.  It's a bug if you have it."),
    message = "",
    teachable = false,
    valid_targets = { "ally" },
    flags = { "PSIONIC", "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    max_level = 20,
    effect = "attack",
    effect_data = "effect_electrokin_revive_debuff",
    shape = "blast",
    min_duration = 360000,
    max_duration = 360000,
    min_aoe = 1,
    max_aoe = 1,
    targeted_species = { "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_light_dodge_monster",
    name = ccb.content.text_without_extraction("[Ψ]Trick of the Light Monster"),
    description = ccb.content.text_without_extraction("Manipulate the light around you, creating small illusions around your body to become harder to hit."),
    valid_targets = { "self" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "RANDOM_DURATION", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_photokin_dodge",
    shape = "blast",
    difficulty = 1,
    min_duration = 5,
    max_duration = 30,
    max_level = 20,
    duration_increment = 1.25,
    energy_source = "STAMINA",
    base_energy_cost = 1700,
    final_energy_cost = 250,
    energy_increment = -216,
    base_casting_time = 100,
    final_casting_time = 100,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_light_explosion_monster",
    name = ccb.content.text_without_extraction("[Ψ]Blinding Explosion Monster"),
    description = ccb.content.text_without_extraction("When you die, you burst apart in an explosion of light."),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_aoe = 1,
    max_aoe = 10,
    aoe_increment = 1,
    min_duration = 500,
    max_duration = 5000,
    duration_increment = 10,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_illumination_monster",
    name = ccb.content.text_without_extraction("[Ψ]Illumination Monster"),
    valid_targets = { "hostile" },
    description = ccb.content.text_without_extraction("Applies an effect that makes the target glow, reducing dodge.  It's a bug if you have it."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_photokinetic_illuminate_enemy",
    damage_type = "psi_photokinetic_damage",
    max_level = 30,
    min_damage = 1,
    max_damage = 1,
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_duration = 2300,
    max_duration = 19500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_illumination_migo",
    name = ccb.content.text_without_extraction("[Ψ]Illumination Migo"),
    valid_targets = { "hostile" },
    description = ccb.content.text_without_extraction("Applies an effect that makes the target glow, reducing dodge.  It's a bug if you have it."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_photokinetic_illumination",
    damage_type = "psi_photokinetic_damage",
    max_level = 30,
    min_damage = 1,
    max_damage = 1,
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_duration = 6300,
    max_duration = 28100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_light_beam_monster",
    name = ccb.content.text_without_extraction("[Ψ]Photon Beam Monster"),
    description = ccb.content.text_without_extraction("Concentrate photons into a high-energy beam."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    shape = "line",
    damage_type = "psi_photokinetic_damage",
    difficulty = 1,
    max_level = 20,
    min_damage = 5,
    max_damage = 15,
    damage_increment = 1,
    min_range = 4,
    max_range = 25,
    range_increment = 1,
    field = "fd_laser",
    min_field_intensity = 2,
    max_field_intensity = 2,
    field_chance = 1,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_flashbang_monster",
    name = ccb.content.text_without_extraction("[Ψ]Flashbang Monster"),
    description = ccb.content.text_without_extraction("Unleash a burst of light and static."),
    valid_targets = { "hostile", "ally" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    effect = "flashbang",
    shape = "blast",
    max_level = 20,
    min_damage = 10,
    max_damage = 200,
    damage_increment = 5,
    min_range = 4,
    max_range = 25,
    range_increment = 1,
    min_aoe = 0,
    max_aoe = 10,
    aoe_increment = 0.25,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_irradiation_aura_monster",
    name = ccb.content.text_without_extraction("[Ψ]Irradiation Aura Monster"),
    description = ccb.content.text_without_extraction("Unleash an aura of radioactive fields  Click, click, click."),
    valid_targets = { "hostile", "ally" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "NO_HANDS", "NO_LEGS" },
    effect = "emit",
    effect_data = "emit_radiation_aura_fields",
    shape = "blast",
    max_level = 20,
    min_range = 1,
    max_range = 1,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_radiation_attack_monster",
    name = ccb.content.text_without_extraction("[Ψ]Radiation Attack Monster"),
    valid_targets = { "hostile" },
    description = ccb.content.text_without_extraction("Applies an effect that causes radiation to the target.  It's a bug if you have it."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_radiation_aura",
    damage_type = "psi_photokinetic_damage",
    max_level = 30,
    min_damage = 1,
    max_damage = 1,
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_duration = 200,
    max_duration = 800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokinetic_light_flash_monster",
    name = ccb.content.text_without_extraction("[Ψ]Star Flash Monster"),
    description = ccb.content.text_without_extraction("Create a destructive flash of light."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "line",
    damage_type = "psi_photokinetic_damage",
    difficulty = 1,
    max_level = 20,
    min_damage = 60,
    max_damage = 150,
    damage_increment = 1,
    min_range = 3,
    max_range = 15,
    range_increment = 1,
    min_aoe = 2,
    max_aoe = 8,
    aoe_increment = 0.3,
    energy_source = "STAMINA",
    base_energy_cost = 3500,
    final_energy_cost = 300,
    energy_increment = -216,
    base_casting_time = 100,
    final_casting_time = 100,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokinetic_eruption_monster",
    name = ccb.content.text_without_extraction("[Ψ]Fountain of Flames Monster"),
    description = ccb.content.text_without_extraction("Cause a burst of flames at the target location."),
    valid_targets = { "hostile", "ground" },
    flags = {
        "CONCENTRATE",
        "LOUD",
        "NO_PROJECTILE",
        "IGNITE_FLAMMABLE",
        "RANDOM_DAMAGE",
        "NO_HANDS",
        "NO_LEGS",
    },
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
    difficulty = 1,
    max_level = 20,
    min_damage = 10,
    max_damage = 30,
    damage_increment = 1,
    min_range = 1,
    max_range = 3,
    range_increment = 0.15,
    energy_source = "STAMINA",
    base_energy_cost = 1500,
    final_energy_cost = 200,
    energy_increment = -216,
    base_casting_time = 100,
    final_casting_time = 100,
    sound_type = "combat",
    sound_description = ccb.content.text("a crackle"),
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokinetic_flash_monster",
    name = ccb.content.text_without_extraction("[Ψ]Brilliant Flash Monster"),
    description = ccb.content.text_without_extraction("By strongly exciting the air at a particular point, you produce a burst of light."),
    valid_targets = { "hostile", "ground" },
    flags = { "CONCENTRATE", "NO_HANDS", "NO_PROJECTILE", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 4,
    max_range = 15,
    range_increment = 1.83,
    min_aoe = 1,
    max_aoe = 5,
    aoe_increment = 0.2,
    min_duration = 100,
    max_duration = 1000,
    duration_increment = 10,
    energy_source = "STAMINA",
    base_energy_cost = 500,
    final_energy_cost = 25,
    energy_increment = -80,
    base_casting_time = 150,
    final_casting_time = 50,
    casting_time_increment = -17,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokinetic_quell_flames_monster",
    name = ccb.content.text_without_extraction("[Ψ]Quell Fire Monster"),
    description = ccb.content.text_without_extraction("Power for monsters to put out flames."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "IGNORE_WALLS", "NO_EXPLOSION_SFX" },
    max_level = 20,
    effect = "ter_transform",
    effect_data = "ter_pyrokin_quell_fire",
    shape = "blast",
    min_aoe = 2,
    max_aoe = 22,
    aoe_increment = 0.5,
}

-- It would be nice if there were an 'affect lower' flag for spells, but alas there is not
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokin_flamethrower_hellhound_monster",
    name = ccb.content.text_without_extraction("[Ψ]Flamethrower Hellhound"),
    description = ccb.content.text("Spray fire in a cone in front of you, if you're a hellhound."),
    message = "",
    teachable = false,
    valid_targets = { "hostile" },
    skill = "metaphysics",
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "LOUD",
        "NO_PROJECTILE",
        "IGNITE_FLAMMABLE",
        "RANDOM_DAMAGE",
        "NO_HANDS",
        "NO_LEGS",
    },
    effect = "attack",
    shape = "cone",
    damage_type = "heat",
    affected_bodyparts = { "torso", "leg_l", "leg_r" },
    min_damage = 10,
    max_damage = 25,
    min_range = 3,
    max_range = 3,
    min_aoe = 60,
    max_aoe = 60,
    field = "fd_fire",
    min_field_intensity = 1,
    max_field_intensity = 2,
    field_chance = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokinetic_flame_armor_ally_monster",
    name = ccb.content.text_without_extraction("[Ψ]Flame Immunity Monster"),
    description = ccb.content.text_without_extraction("Power for monsters to make each other immune to fire."),
    message = "",
    teachable = false,
    valid_targets = { "ally" },
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    max_level = 20,
    effect = "attack",
    effect_data = "effect_monster_pyrokinetic_fire_immunity",
    shape = "blast",
    min_range = 2,
    max_range = 22,
    range_increment = 1,
    min_duration = 3000,
    max_duration = 12000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokinetic_blast_monster",
    name = ccb.content.text_without_extraction("[Ψ]Conflagration Monster"),
    description = ccb.content.text_without_extraction("Create an expanding fireball that catches multiple targets in its wake."),
    valid_targets = { "hostile", "ground" },
    flags = {
        "CONCENTRATE",
        "LOUD",
        "NO_PROJECTILE",
        "IGNITE_FLAMMABLE",
        "RANDOM_DAMAGE",
        "RANDOM_AOE",
        "NO_HANDS",
        "NO_LEGS",
        "SPLIT_DAMAGE",
    },
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
    difficulty = 1,
    max_level = 20,
    min_damage = 60,
    max_damage = 180,
    damage_increment = 1,
    min_range = 3,
    max_range = 10,
    range_increment = 1,
    min_aoe = 1,
    max_aoe = 6,
    aoe_increment = 0.15,
    sound_type = "combat",
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_pull_monster",
    name = ccb.content.text_without_extraction("telekinetic powers"),
    description = ccb.content.text_without_extraction("Pull a target or set of items to you.  This power is for monster usage"),
    message = "",
    valid_targets = { "hostile" },
    spell_class = "TELEKINETIC",
    flags = { "CONCENTRATE", "NO_HANDS", "NO_LEGS" },
    effect = "pull_target",
    shape = "blast",
    difficulty = 1,
    damage_type = "psi_telekinetic_damage",
    max_level = 20,
    min_range = 2,
    max_range = 20,
    range_increment = 1.5,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_momentum_monster",
    name = ccb.content.text_without_extraction("Momentum Alteration Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Momentum Alteration when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "telekinetic_momentum_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_momentum_monster_self",
    name = ccb.content.text_without_extraction("Momentum Alteration Monster Effect"),
    description = ccb.content.text_without_extraction("Grants the Momentum Alteration effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_momentum_alteration",
    shape = "blast",
    min_duration = 12000,
    max_duration = 42000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_barrier_monster",
    name = ccb.content.text_without_extraction("Inertial Barrier Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Inertial Barrier when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "telekinetic_barrier_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_barrier_monster_self",
    name = ccb.content.text_without_extraction("Inertial Barrier Monster Effect"),
    description = ccb.content.text_without_extraction("Grants the Inertial Barrier effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_inertial_barrier",
    shape = "blast",
    min_duration = 12000,
    max_duration = 42000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_barrier_monster_improved",
    name = ccb.content.text_without_extraction("Inertial Barrier Monster Improved enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Inertial Barrier when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "telekinetic_barrier_monster_improved_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_barrier_monster_improved_self",
    name = ccb.content.text_without_extraction("Inertial Barrier Monster Improved Effect"),
    description = ccb.content.text_without_extraction("Grants the Inertial Barrier effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_inertial_barrier_improved",
    shape = "blast",
    min_duration = 12000,
    max_duration = 42000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_hammer_monster",
    name = ccb.content.text_without_extraction("[Ψ]Mindhammer Monster"),
    description = ccb.content.text_without_extraction("Smash a single target with a fist of telekinetic force."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    shape = "blast",
    damage_type = "psi_telekinetic_damage",
    difficulty = 1,
    max_level = 20,
    min_damage = 10,
    max_damage = 40,
    damage_increment = 1,
    min_range = 3,
    max_range = 10,
    range_increment = 0.875,
    sound_type = "combat",
    sound_description = ccb.content.text("a thud"),
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_explosion_monster",
    name = ccb.content.text_without_extraction("Wrecking Ball Monster"),
    description = ccb.content.text_without_extraction("Create an expanding fireball that catches multiple targets in its wake."),
    valid_targets = { "hostile", "ground" },
    flags = {
        "CONCENTRATE",
        "LOUD",
        "NO_PROJECTILE",
        "RANDOM_DAMAGE",
        "RANDOM_AOE",
        "NO_HANDS",
        "NO_LEGS",
        "SPLIT_DAMAGE",
    },
    effect = "attack",
    shape = "blast",
    damage_type = "psi_telekinetic_damage",
    extra_spells = { { spell = "telekinetic_explosion_monster_bash_terrain_monster", self = false } },
    difficulty = 1,
    max_level = 20,
    min_damage = 30,
    max_damage = 140,
    damage_increment = 1.5,
    min_range = 3,
    max_range = 15,
    range_increment = 1,
    min_aoe = 1,
    max_aoe = 6,
    aoe_increment = 0.15,
    sound_type = "combat",
    sound_description = ccb.content.text("a loud crash!"),
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_explosion_monster_bash_terrain_monster",
    name = ccb.content.text_without_extraction("Wrecking Ball Enemy damage"),
    description = ccb.content.text_without_extraction("Damages enemies when you use Wrecking Ball on the ground.  If you have this you debugged it in."),
    valid_targets = { "ally", "hostile", "item", "ground" },
    teachable = false,
    spell_class = "TELEKINETIC",
    flags = { "PSIONIC", "LOUD", "RANDOM_DAMAGE", "IGNORE_WALLS", "RANDOM_AOE" },
    effect = "bash",
    shape = "blast",
    max_level = 20,
    min_damage = 60,
    max_damage = 200,
    min_range = 3,
    max_range = 15,
    range_increment = 1,
    min_aoe = 1,
    max_aoe = 6,
    aoe_increment = 0.15,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_aegis_monster",
    name = ccb.content.text_without_extraction("Aegis Monster Improved enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Aegis when a hostile target is found in a vehicle."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = {
        { spell = "telekinetic_aegis_monster_self", self = true },
        { spell = "telekinetic_aegis_limiter_monster_self", self = true },
    },
    shape = "blast",
    min_range = 15,
    max_range = 15,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_aegis_monster_self",
    name = ccb.content.text_without_extraction("Aegis Monster Effect"),
    description = ccb.content.text_without_extraction("Grants the Aegis effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_telekinetic_aegis",
    shape = "blast",
    min_duration = 6,
    max_duration = 6,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_aegis_limiter_monster_self",
    name = ccb.content.text_without_extraction("Aegis Limiter Monster Effect"),
    description = ccb.content.text_without_extraction("Allows the monster to use Aegis immediately but applies a cooldown afterwards."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_aegis_limiter",
    shape = "blast",
    min_duration = 2500,
    max_duration = 7500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_earthshaker_monster",
    name = ccb.content.text_without_extraction("Earthshaker enemy check"),
    description = ccb.content.text_without_extraction("Makes sure the target is within range before using Earthshaker"),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 20,
    effect = "attack",
    extra_spells = { { spell = "telekinetic_earthshaker_monster_real", self = true } },
    shape = "blast",
    min_range = 10,
    max_range = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_earthshaker_monster_real",
    name = ccb.content.text_without_extraction("Earthshaker Monster"),
    description = ccb.content.text_without_extraction("Seize the nearby earth with your powers and *wrench* it, toppling buildings and knocking everyone nearby off their feet."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "LOUD",
        "NO_HANDS",
        "NO_LEGS",
        "NO_PROJECTILE",
        "IGNORE_WALLS",
        "RANDOM_DURATION",
    },
    effect = "attack",
    effect_data = "downed",
    extra_spells = {
        { spell = "telekinetic_earthshaker_bash_terrain_monster", self = false },
        { spell = "telekinetic_earthshaker_spawn_rubble_monster", self = false },
    },
    shape = "blast",
    min_duration = 200,
    max_duration = 600,
    min_aoe = 10,
    max_aoe = 10,
    sound_description = ccb.content.text("the ground shaking!"),
    sound_id = "earth_spell",
    sound_variant = "strong",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_earthshaker_bash_terrain_monster",
    name = ccb.content.text_without_extraction("Earthshaker Monster Bash Terrain"),
    description = ccb.content.text_without_extraction("Destroy furniture and terrain nearby."),
    valid_targets = { "hostile", "ground" },
    teachable = false,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS", "RANDOM_DAMAGE" },
    effect = "bash",
    shape = "blast",
    min_damage = 50,
    max_damage = 120,
    min_aoe = 10,
    max_aoe = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telekinetic_earthshaker_spawn_rubble_monster",
    name = ccb.content.text_without_extraction("Earthshaker Monster Rubble"),
    description = ccb.content.text_without_extraction("Causes rubble to be spawned occasionally."),
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    effect = "ter_transform",
    effect_data = "telekinetic_earthshaker_transform",
    shape = "blast",
    min_aoe = 10,
    max_aoe = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_confusion_monster",
    name = ccb.content.text_without_extraction("[Ψ]Sensory Deprivation Monster"),
    description = ccb.content.text_without_extraction("Disconnect a target's brain from its senses, leaving it blinded and confused."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    difficulty = 1,
    max_level = 20,
    effect = "attack",
    effect_data = "psi_stunned",
    extra_spells = {
        { spell = "telepathic_deprivation_monster", self = false, max_level = 3 },
        { spell = "telepathic_deafening_monster", self = false, max_level = 3 },
    },
    shape = "blast",
    min_duration = 100,
    max_duration = 500,
    duration_increment = 1,
    min_range = 3,
    max_range = 15,
    range_increment = 1,
    ignored_species = { "ROBOT", "NETHER_EMANATION", "LEECH_PLANT", "WORM", "FUNGUS", "SLIME", "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_hallucinations_monster",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Hallucinations Monster"),
    valid_targets = { "hostile" },
    description = ccb.content.text_without_extraction("Causes the player to hallucinate briefly."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "hallu",
    max_level = 30,
    min_range = 10,
    max_range = 25,
    range_increment = 1,
    min_duration = 30000,
    max_duration = 180000,
    duration_increment = 2000,
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_deprivation_monster",
    name = ccb.content.text_without_extraction("[Ψ]Sensory Deprivation Monster"),
    description = ccb.content.text_without_extraction("By shutting off a target's senses, you can prevent them from seeing anything."),
    valid_targets = { "hostile", "ground" },
    flags = { "CONCENTRATE", "NO_HANDS", "NO_PROJECTILE", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "psi_blind",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 4,
    max_range = 15,
    range_increment = 1.83,
    min_duration = 100,
    max_duration = 1000,
    duration_increment = 10,
    ignored_species = { "ROBOT", "NETHER_EMANATION", "LEECH_PLANT", "WORM", "FUNGUS", "SLIME", "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_deafening_monster",
    name = ccb.content.text_without_extraction("[Ψ]Sensory Deafening Monster"),
    description = ccb.content.text_without_extraction("By shutting off a target's senses, you can prevent them from hearing anything."),
    valid_targets = { "hostile", "ground" },
    flags = { "CONCENTRATE", "NO_HANDS", "NO_PROJECTILE", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "psi_deaf",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 4,
    max_range = 15,
    range_increment = 1.83,
    min_duration = 100,
    max_duration = 1000,
    duration_increment = 10,
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_blast_monster",
    name = ccb.content.text_without_extraction("[Ψ]Synaptic Overload Monster"),
    description = ccb.content.text_without_extraction("Short-circuit and overwhelm a target's brain, causing extreme damage or death.  Does not affect targets without working brains."),
    valid_targets = { "hostile" },
    flags = {
        "CONCENTRATE",
        "NO_PROJECTILE",
        "SILENT",
        "RANDOM_DAMAGE",
        "NO_HANDS",
        "NO_LEGS",
        "PERCENTAGE_DAMAGE",
    },
    difficulty = 1,
    max_level = 20,
    effect = "attack",
    shape = "blast",
    affected_bodyparts = { "head" },
    damage_type = "psi_telepathic_damage",
    min_damage = 5,
    max_damage = 25,
    damage_increment = 1,
    min_range = 5,
    max_range = 20,
    range_increment = 2.5,
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_horror_monster",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Horror Monster"),
    valid_targets = { "hostile" },
    description = ccb.content.text_without_extraction("Reduces the player's speed for a brief period of time and possibly dazes or stuns."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_telepathic_primal_terror",
    max_level = 30,
    min_range = 5,
    max_range = 20,
    range_increment = 1,
    min_duration = 100,
    max_duration = 3000,
    duration_increment = 100,
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}

-- NO_I18N
-- NO_I18N
-- The level scaling with this can get crazy, be especially careful with how high this will go.
ccb.content.define_spell {
    id = "telepathic_fear_blast_monster",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Fear Blast Monster"),
    description = ccb.content.text_without_extraction("Short-circuit and overwhelm a target's brain, causing extreme damage or death, and instilling an extreme primal fear.  Does not affect targets without working brains."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "SILENT", "NO_HANDS", "NO_LEGS" },
    difficulty = 1,
    max_level = 20,
    effect = "attack",
    damage_type = "psi_telepathic_damage",
    min_damage = 1,
    max_damage = 1,
    affected_bodyparts = { "head" },
    extra_spells = {
        { spell = "telepathic_blast_monster", self = false, max_level = 20 },
        { spell = "telepathic_horror_monster", self = false, max_level = 20 },
    },
    shape = "blast",
    min_range = 3,
    max_range = 15,
    range_increment = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_horror_aoe_monster",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Horror AoE Monster"),
    valid_targets = { "ground", "hostile" },
    description = ccb.content.text_without_extraction("Reduces the player's speed for a brief period of time and possibly dazes or stuns.  An AoE around the monster instead of a single-target effect."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "IGNORE_WALLS", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_telepathic_primal_terror",
    damage_type = "psi_telepathic_damage",
    max_level = 30,
    min_damage = 1,
    max_damage = 1,
    min_aoe = 1,
    max_aoe = 30,
    aoe_increment = 1,
    min_duration = 100,
    max_duration = 3000,
    duration_increment = 100,
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_primal_fear_monster",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Primal Fear Monster"),
    valid_targets = { "hostile" },
    description = ccb.content.text_without_extraction("Freezes the player in place briefly."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "mod_moves",
    max_level = 30,
    min_damage = -50,
    max_damage = -500,
    min_range = 10,
    max_range = 25,
    range_increment = 1,
    ignored_species = {
        "ZOMBIE",
        "ROBOT",
        "NETHER",
        "NETHER_EMANATION",
        "LEECH_PLANT",
        "WORM",
        "FUNGUS",
        "SLIME",
        "PSI_NULL",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_self_damage",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Self Damage"),
    description = ccb.content.text_without_extraction("This spell passes through a bit of damage in case something the PSYSHIELD_PARTIAL flag fails, to simulate the failure.  It's a bug if you have it directly."),
    valid_targets = { "self" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "SILENT", "RANDOM_DAMAGE" },
    effect = "attack",
    shape = "blast",
    affected_bodyparts = { "head" },
    damage_type = "psi_telepathic_damage",
    min_damage = 1,
    max_damage = 4,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "whispering_amalgamation_telepathic_whispering_spell",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Amalgamation Whispering"),
    description = ccb.content.text_without_extraction("Amalgamation whispers into your mind, distracting you."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE" },
    effect = "attack",
    effect_data = "effect_whispering_amalgamation_whispers",
    shape = "blast",
    min_range = 30,
    min_duration = 300,
    max_duration = 300,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_shrieking_monster",
    name = ccb.content.text_without_extraction("[Ψ]Telepathic Shrieking Monster"),
    description = ccb.content.text_without_extraction("Causes noise at target location."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_PROJECTILE", "RANDOM_DAMAGE" },
    difficulty = 1,
    max_level = 20,
    effect = "noise",
    shape = "blast",
    min_damage = 10,
    max_damage = 50,
    min_range = 25,
    sound_type = "activity",
    sound_description = ccb.content.text("static"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_network_monster",
    name = ccb.content.text_without_extraction("[Ψ]Network Effect Monster"),
    description = ccb.content.text_without_extraction("AI trigger for only casting when hostiles are present."),
    valid_targets = { "hostile", "ground" },
    effect = "none",
    shape = "blast",
    base_casting_time = 0,
    flags = { "WONDER", "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    min_range = 60,
    max_range = 60,
    extra_spells = { { spell = "telepathic_network_monster_real", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "telepathic_network_monster_real",
    name = ccb.content.text_without_extraction("[Ψ]Network Effect Monster Real"),
    description = ccb.content.text_without_extraction("Adds the telepathic network effect to the monster's ally."),
    valid_targets = { "self", "ally" },
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    difficulty = 9,
    max_level = 20,
    effect = "attack",
    effect_data = "effect_telepath_network_monster_effect",
    shape = "blast",
    min_aoe = 60,
    max_aoe = 60,
    min_duration = 10000,
    max_duration = 30000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_slow_monster",
    name = ccb.content.text_without_extraction("[Ψ]Stutterstep Monster"),
    description = ccb.content.text_without_extraction("Manipulate space to increase relative distance around the target, reducing their speed."),
    valid_targets = { "ground", "hostile" },
    flags = { "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "effect_teleport_slow",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 4,
    max_range = 15,
    range_increment = 1.83,
    min_duration = 200,
    max_duration = 1000,
    duration_increment = 50,
    energy_source = "STAMINA",
    base_energy_cost = 1200,
    final_energy_cost = 200,
    energy_increment = -166.67,
    base_casting_time = 80,
    final_casting_time = 35,
    casting_time_increment = -7.5,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_blink_attack_monster",
    name = ccb.content.text_without_extraction("[Ψ]Force Blink Monster"),
    description = ccb.content.text_without_extraction("Teleport target."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SILENT", "TOUCH_REQUIRED", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_riftwalker_teleport",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 1,
    min_duration = 1000,
    base_casting_time = 50,
    final_casting_time = 0,
    casting_time_increment = -4,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_blink_monster",
    name = ccb.content.text_without_extraction("[Ψ]Blink Monster effect"),
    description = ccb.content.text_without_extraction("The blink you cast if a riftwalker hits you.  It's a bug if you have it."),
    valid_targets = { "none" },
    flags = { "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_AOE" },
    effect = "short_range_teleport",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_aoe = 1,
    max_aoe = 5,
    aoe_increment = 0.25,
    min_range = 10,
    base_casting_time = 50,
    final_casting_time = 0,
    casting_time_increment = -4,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleporter_reactive_displacement_monster",
    name = ccb.content.text_without_extraction("Reactive Displacement Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Reactive Displaccement when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "teleporter_reactive_displacement_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleporter_reactive_displacement_monster_self",
    name = ccb.content.text_without_extraction("Reactive Displacement Monster give Effect"),
    description = ccb.content.text_without_extraction("Grants the Reactive Displacement effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_teleport_reactive_displacement_monster",
    shape = "blast",
    min_duration = 12000,
    max_duration = 42000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_reactive_displacement_monster_teleport",
    name = ccb.content.text_without_extraction("Reactive Displacement Monster Teleport"),
    description = ccb.content.text_without_extraction("Teleports Attackers."),
    teachable = false,
    valid_targets = { "ally", "hostile" },
    spell_class = "TELEPORTER",
    skill = "metaphysics",
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    difficulty = 0,
    max_level = 0,
    effect = "attack",
    shape = "blast",
    damage_type = "psi_teleporter_teleporting_damage",
    min_damage = 1,
    max_damage = 1,
    min_range = 1,
    energy_source = "NONE",
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleporter_warped_strikes_monster",
    name = ccb.content.text_without_extraction("Warped Strikes Monster enemy check"),
    description = ccb.content.text_without_extraction("Preps for using Warped Strikes when a hostile target is detected."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "hostile" },
    max_level = 1,
    effect = "attack",
    extra_spells = { { spell = "teleporter_warped_strikes_monster_self", self = true } },
    shape = "blast",
    min_range = 60,
    max_range = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleporter_warped_strikes_monster_self",
    name = ccb.content.text_without_extraction("Warped Strikes Monster Effect"),
    description = ccb.content.text_without_extraction("Grants the Warped Strikes effect to a monster."),
    flags = { "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "RANDOM_DURATION" },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "effect_monster_warped_strikes",
    shape = "blast",
    min_duration = 6000,
    max_duration = 24000,
}

ccb.content.define_spell {
    id = "teleporter_breach_monster",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    name = ccb.content.text_without_extraction("[Ψ]Breach Monster"),
    description = ccb.content.text_without_extraction("Open a portal to the Nether and summon monsters, if you're also a monster.  This will probably end badly for you but who cares, you're a monster."),
    message = "",
    teachable = false,
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self", "hostile" },
    min_damage = 1,
    min_range = 5,
    range_increment = 1,
    max_range = 80,
    max_level = 30,
    impact_handler = "w16b_sp_imp_mindovermatter_aea82c11ed05",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vitakinetic_health_down",
    name = ccb.content.text_without_extraction("[Ψ]Draining Touch Monster"),
    description = ccb.content.text_without_extraction("Drain Target's Health Mod.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SILENT", "TOUCH_REQUIRED", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_vitakinetic_health_down",
    damage_type = "psi_enervation_damage",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 1,
    min_damage = 1,
    max_damage = 1,
    min_duration = 1080000,
    base_casting_time = 50,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vitakinetic_healing_down",
    name = ccb.content.text_without_extraction("[Ψ]Draining Touch 2 Monster"),
    description = ccb.content.text_without_extraction("Drain Target's Health Mod and reduce healing.  It's a bug if you have it."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "SILENT", "TOUCH_REQUIRED", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_vitakinetic_healing_down",
    damage_type = "psi_enervation_damage",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 1,
    min_damage = 1,
    max_damage = 1,
    min_duration = 1620000,
    base_casting_time = 50,
    ignored_species = { "PSI_NULL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vitakinetic_regeneration_monster",
    name = ccb.content.text_without_extraction("[Ψ]Feral Vitakinetic healing"),
    description = ccb.content.text_without_extraction("Buffs regeneration for a feral vitakinetic.  It's a bug if you have it, and anyway it wouldn't work on you."),
    valid_targets = { "self" },
    flags = { "PSIONIC", "SILENT", "TOUCH_REQUIRED", "NO_LEGS", "RANDOM_DURATION" },
    effect = "attack",
    effect_data = "effect_feral_regeneration",
    shape = "blast",
    min_duration = 200,
    max_duration = 600,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_feral_vitakin3_degenerating_touch",
    name = ccb.content.text_without_extraction("[Ψ]Degenerating Touch Self From Monster"),
    description = ccb.content.text_without_extraction("You are degenerating.  RIP."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    spell_class = "VITAKINETIC",
    skill = "metaphysics",
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "RANDOM_DAMAGE",
        "NO_LEGS",
        "SPLIT_DAMAGE",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    effect = "attack",
    effect_data = "effect_vita_degenerating_touch",
    damage_type = "biological",
    shape = "blast",
    min_dot = 4,
    max_dot = 10,
    min_duration = 1500,
    max_duration = 6500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vita_feral_vitakin3_degenerating_touch_monster",
    name = ccb.content.text_without_extraction("[Ψ]Degenerating Touch Self From Monster to Monster"),
    description = ccb.content.text_without_extraction("You are degenerating.  RIP."),
    message = "",
    teachable = false,
    valid_targets = { "self" },
    spell_class = "VITAKINETIC",
    skill = "metaphysics",
    flags = {
        "PSIONIC",
        "CONCENTRATE",
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
        "NO_EXPLOSION_SFX",
    },
    effect = "attack",
    effect_data = "effect_vita_degenerating_touch",
    damage_type = "biological",
    shape = "blast",
    min_dot = 1,
    max_dot = 4,
    min_duration = 1500,
    max_duration = 6500,
}

-- NO_I18N
ccb.content.define_spell {
    id = "hidebehind_apply_mindsight",
    name = ccb.content.text_without_extraction("Hidebehind apply mindsight"),
    description = ccb.content.text("Add the effect to give the hidebehind mindsight."),
    flags = {
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "MUST_HAVE_CLASS_TO_LEARN",
        "HIDDEN_SPELL",
    },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "eff_mind_seeing_bonus_20",
    shape = "blast",
    min_range = 0,
    max_range = 0,
    min_duration = 900000,
    max_duration = 900000,
}

-- NO_I18N
ccb.content.define_spell {
    id = "eater_apply_mindsight",
    name = ccb.content.text_without_extraction("Eater apply mindsight"),
    description = ccb.content.text("Add the effect to give the eater mindsight."),
    flags = {
        "SILENT",
        "NO_HANDS",
        "NO_LEGS",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "MUST_HAVE_CLASS_TO_LEARN",
        "HIDDEN_SPELL",
    },
    valid_targets = { "self" },
    max_level = 1,
    effect = "attack",
    effect_data = "eff_mind_seeing_bonus_30",
    shape = "blast",
    min_range = 0,
    max_range = 0,
    min_duration = 900000,
    max_duration = 900000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "small_psi_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Psi Raptors"),
    description = ccb.content.text_without_extraction("Summons a few zombiespawn psi raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX", "SPAWN_GROUP" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "GROUP_SPAWN_PSI_RAPTOR",
}

ccb.content.define_spell {
    id = "pigeon_aura",
    shape = "blast",
    name = ccb.content.text_without_extraction("Pigeon aura"),
    description = ccb.content.text_without_extraction("Anyone nearby will get stronger."),
    flags = { "SILENT", "NO_LEGS", "NO_FAIL" },
    valid_targets = { "self" },
    energy_source = "NONE",
    min_range = 30,
    max_range = 30,
    base_energy_cost = 0,
    difficulty = 0,
    base_casting_time = 500,
    impact_handler = "w16b_sp_imp_mindovermatter_c06d85907bdf",
}
