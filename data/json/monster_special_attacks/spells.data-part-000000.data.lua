local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Listed as a recover energy effect with a negative modifier that decreases with each level of the spell, which makes it cause damage instead.
ccb.content.define_spell {
    id = "pain_damage",
    name = ccb.content.text_without_extraction("Pain"),
    description = ccb.content.text_without_extraction("Increases pain."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = -25,
    max_damage = -225,
    damage_increment = -50.0,
    max_level = 10,
    shape = "blast",
    effect = "recover_energy",
    effect_data = "PAIN",
}

-- NO_I18N
-- NO_I18N
-- Listed as a recover energy effect with a negative modifier that decreases with each level of the spell, which makes it cause damage instead.
ccb.content.define_spell {
    id = "stamina_damage",
    name = ccb.content.text_without_extraction("Tired"),
    description = ccb.content.text_without_extraction("Decreases stamina."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = -2000,
    max_damage = -10000,
    damage_increment = -2000.0,
    max_level = 10,
    shape = "blast",
    effect = "recover_energy",
    effect_data = "STAMINA",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_summon_zombie_gasbag_crawler",
    name = ccb.content.text_without_extraction("Summon Gangrenous Crawlers"),
    description = ccb.content.text_without_extraction("Summons 2 permanent gangrenous crawlers."),
    flags = { "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_range = 0,
    max_range = 0,
    min_aoe = 3,
    max_aoe = 3,
    base_casting_time = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_zombie_gasbag_crawler",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "crushed_giant_summoning",
    name = ccb.content.text_without_extraction("Summon Gangrenous Monsters"),
    description = ccb.content.text_without_extraction("Summons 2 permanent gangrenous impalers."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground" },
    extra_spells = { { spell = "mon_summon_zombie_gasbag_crawler" } },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_range = 0,
    max_range = 0,
    min_aoe = 3,
    max_aoe = 3,
    base_casting_time = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_zombie_gasbag_impaler",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "frog_mother_summon",
    name = ccb.content.text_without_extraction("Summon Tadpole Constrictors"),
    description = ccb.content.text_without_extraction("Summons several temporary tadpoles."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self", "hostile" },
    min_damage = 2,
    max_damage = 5,
    min_range = 7,
    max_range = 7,
    min_aoe = 3,
    max_aoe = 3,
    base_casting_time = 80,
    min_duration = 1000,
    max_duration = 2500,
    extra_spells = { { spell = "frog_mother_hurt_self", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_tadpole_grabber",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wretch_hurt_self",
    name = ccb.content.text_without_extraction("Wretch Hurt Self"),
    description = ccb.content.text_without_extraction("Hurts yourself."),
    flags = { "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 5,
    max_damage = 15,
    damage_type = "cut",
    valid_targets = { "hostile", "ally", "self", "ground" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "frog_mother_hurt_self",
    name = ccb.content.text_without_extraction("Frog Mother Hurt Self"),
    description = ccb.content.text_without_extraction("Hurts yourself."),
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 10,
    max_damage = 20,
    damage_type = "cut",
    valid_targets = { "hostile", "ally", "self", "ground" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fragile_frog_leap",
    name = ccb.content.text_without_extraction("Fragile Frog Leap"),
    description = ccb.content.text_without_extraction("Cast after a burned frog monster leaps; causes self harm and creates a smoke cloud."),
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 0,
    message = "",
    min_damage = 10,
    max_damage = 15,
    damage_type = "cut",
    valid_targets = { "self", "hostile", "ground" },
    shape = "blast",
    field = "fd_smoke",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
    min_aoe = 2,
    max_aoe = 3,
    effect = "attack",
    min_range = 1,
    max_range = 1,
    extra_spells = { { spell = "fragile_no_more", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dusty_frog_leap",
    name = ccb.content.text_without_extraction("Dusty Frog Leap"),
    description = ccb.content.text_without_extraction("Cast after a burned frog monster leaps; causes self harm and creates a smoke plume."),
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 0,
    message = "",
    min_damage = 5,
    max_damage = 10,
    damage_type = "cut",
    valid_targets = { "self", "hostile", "ground" },
    shape = "blast",
    field = "fd_smoke",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 1,
    min_aoe = 1,
    max_aoe = 2,
    effect = "attack",
    min_range = 1,
    max_range = 1,
    extra_spells = { { spell = "fragile_no_more", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "fragile_no_more",
    name = ccb.content.text_without_extraction("Fragile No More"),
    description = ccb.content.text_without_extraction("removes conditional effect for burned frogs crumble after leaping."),
    valid_targets = { "self" },
    effect = "remove_effect",
    effect_data = "fragile_frog",
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "small_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Raptors"),
    description = ccb.content.text_without_extraction("Summons a few zombiespawn raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_spawn_raptor",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "big_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Many Raptors"),
    description = ccb.content.text_without_extraction("Summons many zombiespawn raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 3,
    max_damage = 6,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_spawn_raptor",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wretch_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Raptor"),
    description = ccb.content.text_without_extraction("Summons a flesh raptor while dealing some damage to the zombie."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "wretch_hurt_self", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_spawn_raptor",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hive_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Raptor"),
    description = ccb.content.text_without_extraction("Summons a zombie-spawn raptor without killing the zombie."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 4,
    max_aoe = 4,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_spawn_raptor",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shady_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Shady Raptors"),
    description = ccb.content.text_without_extraction("Summons a few shady zombiespawn raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_spawn_raptor_shady",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wretch_fungal_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Raptor"),
    description = ccb.content.text_without_extraction("Summons a fungal flesh raptor while dealing some damage to the zombie."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "wretch_hurt_self", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_fungal_raptor",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "small_fungal_raptor_spawn",
    name = ccb.content.text_without_extraction("Summon Fungal Raptors"),
    description = ccb.content.text_without_extraction("Summons a few fungal raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    min_aoe = 4,
    max_aoe = 4,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_fungal_raptor",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spawning_zombie_die",
    name = ccb.content.text_without_extraction("Spawning Zombie Die"),
    description = ccb.content.text_without_extraction("For zombies that are spawning something and die in the process."),
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX", "EXTRA_EFFECTS_FIRST" },
    min_damage = 2000,
    max_damage = 2000,
    damage_type = "pure",
    valid_targets = { "self" },
    extra_spells = { { spell = "soft_squelch", self = true } },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "soft_squelch",
    name = ccb.content.text_without_extraction("Soft Squelch"),
    description = ccb.content.text_without_extraction("Noise, emitted by the monster when it explode with gore."),
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 6,
    max_damage = 16,
    sound_type = "combat",
    sound_description = ccb.content.text("a loud tearing!"),
    valid_targets = { "self" },
    shape = "blast",
    effect = "noise",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "phase_skulker_teleport",
    name = ccb.content.text_without_extraction("Phase Skulker Teleport"),
    description = ccb.content.text_without_extraction("Teleports the monster."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "none" },
    flags = { "SOMATIC", "SILENT", "NO_LEGS", "NO_EXPLOSION_SFX" },
    min_range = 2,
    max_range = 12,
    min_aoe = 2,
    max_aoe = 12,
    base_casting_time = 100,
}
