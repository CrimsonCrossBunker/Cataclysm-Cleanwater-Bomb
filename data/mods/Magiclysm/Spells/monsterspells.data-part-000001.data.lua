local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_wisps_monster",
    name = ccb.content.text_without_extraction("Ignus Fatuus Monster"),
    description = ccb.content.text_without_extraction("Summons ghostly foxfire worked from living marsh vapor to lead your enemies astray.  With more experience, this spell can conjure multiple ghost lights."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_wisp",
    shape = "blast",
    flags = { "CONJURATION_SPELL", "LOUD", "SOMATIC", "HOSTILE_SUMMON" },
    energy_source = "MANA",
    difficulty = 2,
    max_level = 25,
    min_damage = 1,
    max_damage = 8,
    damage_increment = 0.28,
    min_aoe = 3,
    max_aoe = 3,
    min_range = 3,
    max_range = 7,
    range_increment = 0.16,
    min_duration = 6000,
    max_duration = 60000,
    duration_increment = 2160,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "windrun_monster",
    name = ccb.content.text_without_extraction("Windrunning Monster"),
    description = ccb.content.text_without_extraction("A magical wind pushes you forward as you move, easing your movements and increasing speed."),
    energy_source = "MANA",
    difficulty = 1,
    effect = "attack",
    effect_data = "enchant_windrun_monster",
    shape = "blast",
    valid_targets = { "self" },
    flags = { "ENHANCEMENT_SPELL", "SILENT", "VERBAL", "NO_HANDS", "NO_PROJECTILE" },
    max_level = 10,
    min_duration = 6000,
    max_duration = 30000,
    duration_increment = 2400,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "necrotic_gaze_monster",
    name = ccb.content.text_without_extraction("Necrotic Gaze Monster"),
    description = ccb.content.text_without_extraction("Like the animist spell, but for monsters"),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "line",
    flags = { "NO_LEGS", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_HANDS", "SPLIT_DAMAGE" },
    min_damage = 30,
    max_damage = 80,
    min_range = 3,
    max_range = 5,
    range_increment = 0.1,
    max_level = 25,
    difficulty = 3,
    base_casting_time = 100,
    min_aoe = 1,
    max_aoe = 3,
    aoe_increment = 0.1,
    damage_type = "necrotic",
}

-- NO_I18N
ccb.content.define_spell {
    id = "ethereal_grasp_monster",
    name = ccb.content.text_without_extraction("Ethereal Grasp"),
    description = ccb.content.text("A mass of spectral hands emerge from the ground, slowing everything in range.  Higher levels allow a bigger AoE, and longer effect."),
    effect = "attack",
    effect_data = "effect_ethereal_grasp_monster",
    shape = "blast",
    affected_bodyparts = { "foot_l", "foot_r" },
    valid_targets = { "hostile", "ground" },
    max_level = 20,
    min_aoe = 2,
    max_aoe = 20,
    aoe_increment = 0.5,
    min_range = 5,
    max_range = 20,
    range_increment = 2.0,
    min_duration = 1000,
    max_duration = 5000,
    duration_increment = 200,
    spell_class = "NONE",
    flags = { "SOMATIC", "NO_PROJECTILE" },
    damage_type = "bash",
}

-- NO_I18N
ccb.content.define_spell {
    id = "druid_veggrasp_monster",
    name = ccb.content.text_without_extraction("Vegetative Grasp Monster"),
    description = ccb.content.text("This spell causes roots and vines to burst forth from the ground and grab your foes, slowing them and doing a small amount of damage as they dig in."),
    valid_targets = { "hostile", "ground" },
    flags = { "EVOCATION_SPELL", "LOUD", "SOMATIC", "VERBAL", "NO_LEGS", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    effect = "attack",
    effect_data = "entangled_monster",
    shape = "blast",
    spell_class = "NONE",
    difficulty = 2,
    max_level = 20,
    min_damage = 1,
    max_damage = 10,
    damage_increment = 0.5,
    min_aoe = 2,
    max_aoe = 8,
    aoe_increment = 0.5,
    min_range = 3,
    max_range = 10,
    range_increment = 1.0,
    min_duration = 1000,
    max_duration = 10000,
    duration_increment = 500,
    min_pierce = 1,
    max_pierce = 5,
    pierce_increment = 0.25,
    min_dot = 0.1,
    max_dot = 0.3,
    dot_increment = 0.01,
    damage_type = "stab",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "natural_spirit_zombie_decay",
    name = ccb.content.text_without_extraction("Nature spirit anti-zombie spell"),
    description = ccb.content.text_without_extraction("Cause zombies to rot away into nothingness.  You can't get this spell, though, you're not in tune with nature enough."),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    flags = {
        "VERBAL",
        "SOMATIC",
        "NO_LEGS",
        "RANDOM_DURATION",
        "RANDOM_AOE",
        "IGNORE_WALLS",
        "NO_PROJECTILE",
        "NO_HANDS",
    },
    damage_type = "biological",
    max_level = 25,
    min_range = 15,
    max_range = 15,
    min_duration = 1000,
    max_duration = 2500,
    min_aoe = 4,
    max_aoe = 7,
    min_dot = 5,
    max_dot = 10,
    targeted_species = { "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "seeker_bolts_levinbolt_spell",
    name = ccb.content.text_without_extraction("Zombie Seeker Bolts"),
    description = ccb.content.text_without_extraction("I cast seeker bolts at the living."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE", "NO_LEGS", "SILENT", "NO_PROJECTILE" },
    min_damage = 10,
    max_damage = 30,
    damage_type = "nether",
    multiple_projectiles = 3,
    min_range = 8,
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "manastorm_zombie_spell",
    name = ccb.content.text_without_extraction("Zombie Mana Blast"),
    description = ccb.content.text_without_extraction("A magical explosion that leyspark zombies use."),
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "RANDOM_DAMAGE", "NO_LEGS", "SILENT", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    min_damage = 50,
    max_damage = 150,
    damage_type = "nether",
    min_aoe = 3,
    max_aoe = 3,
    min_range = 12,
    shape = "blast",
    effect = "attack",
}
