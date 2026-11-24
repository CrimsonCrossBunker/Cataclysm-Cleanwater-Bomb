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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "centipede_mom_summon",
    name = ccb.content.text_without_extraction("Summon Centipede"),
    description = ccb.content.text_without_extraction("Summons a small, sometimes pissed off centipede."),
    flags = {
        "HOSTILE_SUMMON",
        "PERMANENT",
        "RANDOM_TARGET",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "SPAWN_GROUP",
    },
    valid_targets = { "ground" },
    base_casting_time = 200,
    min_range = 1,
    max_range = 3,
    min_damage = 1,
    max_damage = 1,
    min_aoe = 1,
    max_aoe = 1,
    shape = "line",
    effect = "summon",
    effect_data = "GROUP_CENTIPEDE_MOM_SUMMON",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "phase_shrike_teleport",
    name = ccb.content.text_without_extraction("Phase Skulker Teleport"),
    description = ccb.content.text_without_extraction("Electric explosion followed by a teleport."),
    extra_spells = { { spell = "phase_skulker_teleport", self = true } },
    valid_targets = { "hostile", "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_damage = 5,
    max_damage = 10,
    damage_type = "electric",
    min_aoe = 4,
    max_aoe = 8,
    min_range = 2,
    max_range = 6,
    field = "fd_electricity",
    field_chance = 3,
    min_field_intensity = 1,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spur_shrill",
    name = ccb.content.text_without_extraction("Spur Shrill"),
    description = ccb.content.text_without_extraction("Heals nearby scrap swarms."),
    valid_targets = { "hostile", "ground", "self", "ally" },
    targeted_monsters = { "mon_shrapnel_swarm" },
    effect = "attack",
    shape = "blast",
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_damage = -50,
    max_damage = -100,
    min_aoe = 12,
    max_aoe = 12,
    min_range = 2,
    max_range = 6,
    field = "fd_biolum",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shock_cone",
    name = ccb.content.text_without_extraction("an arc of electricity"),
    description = ccb.content.text_without_extraction("Spawns electric fields."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    max_level = 5,
    min_damage = 0,
    max_damage = 0,
    min_aoe = 10,
    max_aoe = 15,
    aoe_increment = 1,
    min_range = 8,
    max_range = 16,
    range_increment = 2,
    base_casting_time = 50,
    field = "fd_electricity",
    min_field_intensity = 3,
    max_field_intensity = 9,
    field_intensity_increment = 1,
    field_intensity_variance = 1,
    field_chance = 4,
    damage_type = "electric",
    sound_type = "combat",
    sound_id = "fire_gun",
    sound_variant = "bio_lightning",
    sound_description = ccb.content.text("a crackle"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shock_blast",
    name = ccb.content.text_without_extraction("Shock Blast"),
    description = ccb.content.text_without_extraction("Spawns electric fields in a blast"),
    base_casting_time = 10,
    effect = "attack",
    shape = "blast",
    valid_targets = { "self", "ground" },
    flags = { "LOUD", "SPLIT_DAMAGE" },
    damage_type = "electric",
    max_level = 4,
    min_damage = 4,
    max_damage = 16,
    damage_increment = 4,
    min_range = 1,
    max_range = 5,
    range_increment = 1,
    min_aoe = 1,
    max_aoe = 5,
    aoe_increment = 1,
    field = "fd_electricity",
    min_field_intensity = 3,
    max_field_intensity = 9,
    field_intensity_increment = 2,
    field_chance = 2,
    field_intensity_variance = 0.2,
    effect_data = "maimed_capacitor",
    min_duration = 2000,
    max_duration = 2000,
    extra_spells = { { spell = "hit_and_run", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hit_and_run",
    name = ccb.content.text_without_extraction("Running Away"),
    description = ccb.content.text_without_extraction("Causes monster to run away for 5 turns."),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    effect = "attack",
    shape = "blast",
    effect_data = "run",
    min_duration = 500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dermatik_emergence",
    name = ccb.content.text_without_extraction("Dermatik Emergence"),
    description = ccb.content.text_without_extraction("The incubating dermatik larvae flee their host."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    base_casting_time = 20,
    min_range = 1,
    max_range = 5,
    min_damage = 1,
    max_damage = 3,
    damage_type = "stab",
    min_aoe = 2,
    max_aoe = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_dermatik_larva",
    extra_spells = { { spell = "frog_mother_hurt_self", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_juv_dermatik_wingmolt_spell",
    name = ccb.content.text_without_extraction("Attempt to molt wings"),
    description = ccb.content.text_without_extraction("redbull-gives you wings!"),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "NO_PROJECTILE" },
    effect = "targeted_polymorph",
    effect_data = "mon_dermatik_juvenile",
    shape = "blast",
    spell_class = "NONE",
    base_casting_time = 50,
    difficulty = 0,
    max_level = 1,
    min_damage = 9999,
    max_damage = 9999,
    damage_type = "pure",
    min_range = 30,
    max_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mutant_frenzy",
    name = ccb.content.text_without_extraction("Mutant Frenzy"),
    description = ccb.content.text_without_extraction("Speeds up allied mutants in a radius."),
    valid_targets = { "ally" },
    targeted_monsters = {
        "mon_mutant_antler",
        "mon_mutant_arthropod",
        "mon_mutant_camouflaged",
        "mon_mutant_mollusk",
        "mon_mutant_experimental",
        "mon_mutant_evolved",
    },
    effect = "attack",
    shape = "blast",
    effect_data = "frenzy",
    max_level = 1,
    min_range = 10,
    max_range = 10,
    min_aoe = 8,
    max_aoe = 12,
    min_damage = 0,
    max_damage = 0,
    min_duration = 9000,
    max_duration = 9000,
    base_casting_time = 200,
    flags = { "RANDOM_AOE", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spread_sludge",
    name = ccb.content.text_without_extraction("Spread Sludge"),
    description = ccb.content.text_without_extraction("Splatters sludge along the ground in a cone."),
    valid_targets = { "hostile", "ground" },
    max_level = 1,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    min_aoe = 45,
    max_aoe = 45,
    base_casting_time = 75,
    min_range = 4,
    max_range = 4,
    effect = "attack",
    shape = "cone",
    field = "fd_sludge",
    field_chance = 2,
    min_field_intensity = 2,
    max_field_intensity = 2,
}

ccb.content.define_spell {
    id = "HEKATONKHEIRE_REND_AND_TEAR",
    shape = "blast",
    effect = "attack",
    damage_type = "cut",
    name = ccb.content.text_without_extraction("Rend and Tear"),
    description = ccb.content.text_without_extraction("Begins drawing and quartering the victim."),
    flags = { "LOUD", "SPLIT_DAMAGE", "RANDOM_DAMAGE" },
    valid_targets = { "hostile" },
    min_damage = { handler = "wave14a_dda_stat_7", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_8", fallback = 0 },
    min_range = 1,
    range_increment = 1,
    max_range = 1,
    min_aoe = 1,
    aoe_increment = 1,
    max_aoe = 1,
    max_level = 1,
    base_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shifting_mass_attack",
    name = ccb.content.text_without_extraction("Shifting Mass Attack"),
    description = ccb.content.text_without_extraction("Drains some of your essence."),
    copy_from = "base_portal",
    min_damage = -25,
    max_damage = -50,
    damage_increment = -10.0,
    effect_data = "EOC_shifting_mass_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "portal_hurt_self",
    name = ccb.content.text_without_extraction("Hurt Self"),
    description = ccb.content.text_without_extraction("Touching/perceiving you is bad for the other side as well."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 5,
    max_damage = 5,
    damage_type = "pure",
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "portal_severely_hurt_self",
    name = ccb.content.text_without_extraction("Hurt Self"),
    description = ccb.content.text_without_extraction("Touching/perceiving you is bad for the other side as well."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 30,
    max_damage = 30,
    damage_type = "pure",
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
}

ccb.content.define_spell {
    id = "base_portal",
    shape = "blast",
    name = ccb.content.text_without_extraction("Base characteristics of portal spells"),
    description = ccb.content.text_without_extraction("Base portal stats."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 1,
    max_range = 1,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_ba42177bae6f",
    extra_spells = {
        { spell = "portal_hurt_self", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "impossible_shape_attack",
    name = ccb.content.text_without_extraction("Impossible Shape Attack"),
    description = ccb.content.text_without_extraction("Hurts you mentally."),
    copy_from = "base_portal",
    min_range = 50,
    max_range = 50,
    effect_data = "EOC_impossible_shape_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "absence_capture_attack",
    name = ccb.content.text_without_extraction("Absence Capture Attack"),
    description = ccb.content.text_without_extraction("Traps you with nothing."),
    copy_from = "base_portal",
    min_range = 12,
    max_range = 12,
    effect_data = "EOC_absence_capture_attack",
}

-- NO_I18N
-- NO_I18N
-- Duration is 3-5 hours, can't seem to write it in hours, had to write it in moves which is terrible
ccb.content.define_spell {
    id = "skunk_squirt",
    name = ccb.content.text_without_extraction("Skunk Spray"),
    description = ccb.content.text_without_extraction("Skunk spray defense mechanism."),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "cone",
    min_range = 4,
    max_range = 4,
    min_duration = 1080000,
    max_duration = 1800000,
    flags = { "RANDOM_DURATION" },
    effect_data = "skunk_spray",
}

-- exist because zed try to use boomer_claymore on max range except trying to minimize the distance (ty venera for idea)
-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boomer_claymore_initial",
    name = ccb.content.text_without_extraction("Initial Boomer Claymore Attack"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile" },
    flags = { "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    min_damage = 0,
    max_damage = 0,
    min_range = 3,
    max_range = 3,
    extra_spells = { { spell = "boomer_claymore" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boomer_claymore",
    name = ccb.content.text_without_extraction("Boomer Claymore Attack"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "cone",
    min_damage = 30,
    max_damage = 30,
    damage_type = "cut",
    min_range = 6,
    max_range = 6,
    min_aoe = 120,
    max_aoe = 120,
    extra_spells = { { spell = "boomer_claymore_suicide", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "create_noise",
    name = ccb.content.text_without_extraction("Do noise"),
    description = ccb.content.text_without_extraction("Causes some noise"),
    flags = { "NO_EXPLOSION_SFX" },
    message = ccb.content.text("The %s makes a deafening screech"),
    sound_description = ccb.content.text("a deafening screech"),
    sound_type = "combat",
    sound_ambient = true,
    sound_id = "misc",
    sound_variant = "shockwave",
    min_damage = 50,
    max_damage = 50,
    valid_targets = { "self" },
    shape = "blast",
    effect = "noise",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boomer_claymore_suicide",
    name = ccb.content.text_without_extraction("Boomer Suicide Spell"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile", "ally", "self" },
    effect = "attack",
    shape = "blast",
    damage_type = "biological",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 9999,
    max_damage = 9999,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_twisting_blade_attack",
    name = ccb.content.text_without_extraction("Twisting Blade Attack"),
    description = ccb.content.text_without_extraction("Hurts you mentally."),
    copy_from = "base_portal",
    effect_data = "EOC_mon_twisting_blade_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_swarm_structure_attack",
    name = ccb.content.text_without_extraction("Swarm Structure Action"),
    description = ccb.content.text_without_extraction("Teleports and summons monsters."),
    copy_from = "base_portal",
    extra_spells = { { spell = "portal_severely_hurt_self", self = true } },
    min_range = 15,
    max_range = 15,
    effect_data = "EOC_mon_swarm_structure_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_reflection_attack",
    name = ccb.content.text_without_extraction("Reflection Action"),
    description = ccb.content.text_without_extraction("Teleports and harms monsters."),
    copy_from = "base_portal",
    min_range = 15,
    max_range = 15,
    effect_data = "EOC_mon_reflection_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hallu_touch_suicide",
    name = ccb.content.text_without_extraction("Hallucination Touch Dissipation"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile", "ally", "self" },
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    damage_type = "pure",
    min_damage = 100000000,
    max_damage = 100000000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hallucinator_touch",
    name = ccb.content.text_without_extraction("Give The Hallucination Effect"),
    description = ccb.content.text_without_extraction("Spell that gives the player the effect, that will cause short term hallucination attacks.  You can see it only in debug menu."),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "hallucination_attacks",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 0,
    max_damage = 0,
    min_range = 1,
    max_range = 1,
    min_duration = 25920000,
    max_duration = 25920000,
    extra_spells = { { spell = "hallu_touch_suicide", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flatlander_attack",
    name = ccb.content.text_without_extraction("flatlander attack"),
    description = ccb.content.text_without_extraction("Dazes the player"),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "stunned",
    min_range = 4,
    max_range = 4,
    shape = "blast",
    message = "",
    min_duration = 100,
    max_duration = 400,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    extra_spells = { { spell = "flatlander_attack_nausea" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flatlander_attack_nausea",
    name = ccb.content.text_without_extraction("flatlander attack nausea"),
    description = ccb.content.text_without_extraction("Makes enemy nauseous"),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    message = "",
    min_duration = 300,
    max_duration = 1000,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    effect_data = "nausea",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sloth_attack",
    name = ccb.content.text_without_extraction("Sloth Attack"),
    description = ccb.content.text_without_extraction("Slows you."),
    copy_from = "base_portal",
    effect_data = "EOC_sloth_attack",
}

ccb.content.define_spell {
    id = "mon_XEDRA_officer_banish",
    shape = "blast",
    name = ccb.content.text_without_extraction("Officer banish"),
    description = ccb.content.text_without_extraction("Stops the haunting."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self", "ground" },
    min_range = 15,
    max_range = 15,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_524665f3baae",
}

ccb.content.define_spell {
    id = "mon_tainted_shadow_revive",
    shape = "blast",
    name = ccb.content.text_without_extraction("Tainted Shadow Revive"),
    description = ccb.content.text_without_extraction("Revives the tainted shadow."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "ground" },
    min_range = 15,
    max_range = 15,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_321a1ae0df67",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_conjure_memories",
    name = ccb.content.text_without_extraction("Life Flashing"),
    description = ccb.content.text_without_extraction("Brings back memories."),
    copy_from = "base_portal",
    max_range = 3,
    effect_data = "EOC_conjure_memories",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "guilt_attack",
    name = ccb.content.text_without_extraction("Guilt Attack"),
    description = ccb.content.text_without_extraction("Makes things heavier."),
    copy_from = "base_portal",
    effect_data = "EOC_guilt_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wraith_summon_shadow",
    name = ccb.content.text_without_extraction("Wraith Summon Shadow"),
    description = ccb.content.text_without_extraction("Summons hostile shadows."),
    effect = "summon",
    effect_data = "mon_shadow",
    message = "",
    shape = "blast",
    valid_targets = { "self", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "HOSTILE_SUMMON" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 2,
    max_aoe = 2,
    min_duration = 30000,
    max_duration = 30000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wraith_apply_darkness",
    name = ccb.content.text_without_extraction("Wraith Apply Darkness"),
    description = ccb.content.text_without_extraction("Applies the darkness effect"),
    effect = "attack",
    effect_data = "darkness",
    message = "",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_range = 35,
    max_range = 35,
    min_duration = 6000,
    max_duration = 6000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "blank_body_avatar_copy_polymorph",
    name = ccb.content.text_without_extraction("Blank Body Player Copy"),
    description = ccb.content.text_without_extraction("Blank body copies the player"),
    message = ccb.content.text("The blank body's flesh suddenly begins to flow like wax, warping and changing, and when it's done it's…you."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX", "HIDDEN_SPELL" },
    effect = "targeted_polymorph",
    effect_data = "mon_blank_avatar_copy",
    valid_targets = { "self" },
    min_damage = 10000,
    max_damage = 10000,
    base_casting_time = 200,
    shape = "blast",
}

ccb.content.define_spell {
    id = "fear_paralyze",
    shape = "blast",
    name = ccb.content.text_without_extraction("Fear Paralyze"),
    description = ccb.content.text_without_extraction("Paralyzes you when you see the creature."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 10,
    max_range = 10,
    impact_handler = "w16b_sp_imp_dda_ea5c7fd5f297",
}

ccb.content.define_spell {
    id = "stare",
    shape = "blast",
    name = ccb.content.text_without_extraction("Stare"),
    description = ccb.content.text_without_extraction("Applies various effects when you see the creature."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 150,
    max_range = 150,
    impact_handler = "w16b_sp_imp_dda_b17489876567",
}

ccb.content.define_spell {
    id = "blank_body_avatar_copy",
    shape = "blast",
    name = ccb.content.text_without_extraction("Blank Body Player Copy Check"),
    description = ccb.content.text_without_extraction("Blank body checks and might copy the player.  Needs to be the avatar to apply COPY_AVATAR_LOOK"),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "hostile", "ally" },
    min_aoe = 1,
    max_aoe = 1,
    base_casting_time = 200,
    impact_handler = "w16b_sp_imp_dda_5cc4b498ce51",
}

ccb.content.define_spell {
    id = "veiled_butterfly_irradiate",
    shape = "blast",
    name = ccb.content.text_without_extraction("Irradiate Player"),
    description = ccb.content.text_without_extraction("Adds minor radiation to player."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 1,
    max_range = 5,
    min_aoe = 1,
    max_aoe = 1,
    base_casting_time = 200,
    impact_handler = "w16b_sp_imp_dda_db98276fff7d",
}

ccb.content.define_spell {
    id = "mon_zombie_summoner_summon_hordes_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Summon Horde"),
    description = ccb.content.text_without_extraction("Calls hordes to the player's location."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 10,
    max_range = 10,
    impact_handler = "w16b_sp_imp_dda_26c4e01c0faf",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flying_polyp_out_of_phase_spell",
    name = ccb.content.text_without_extraction("Polyp Out of Phase"),
    description = ccb.content.text_without_extraction("Flying Polyps cast this on spawn."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_polyp_out_of_phase",
    valid_targets = { "self" },
    base_casting_time = 200,
    min_duration = 84600,
    max_duration = 84600,
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pallid_horror_spawn",
    name = ccb.content.text_without_extraction("Summon Pallid Horror"),
    description = ccb.content.text_without_extraction("Summons a pallid horror."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX", "SILENT" },
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 1,
    max_aoe = 1,
    extra_spells = { { spell = "spawning_zombie_die", self = true } },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_inner_cabins_interstice_horror",
}

ccb.content.define_spell {
    id = "cellar_spider_leg_detach",
    shape = "blast",
    name = ccb.content.text_without_extraction("Detach Leg"),
    description = ccb.content.text_without_extraction("The hurt leg of the cellar spider wriggles loose.  Ew."),
    flags = { "HOSTILE_SUMMON", "NO_PROJECTILE", "RANDOM_TARGET", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_range = 1,
    min_aoe = 3,
    base_casting_time = 10,
    impact_handler = "w16b_sp_imp_dda_a6367bbee809",
    extra_spells = {
        { spell = "frog_mother_hurt_self", self = true },
        { spell = "frog_mother_hurt_self", self = true },
    },
}
