local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "blood_suck",
    name = ccb.content.text_without_extraction("Blood Suck"),
    description = ccb.content.text_without_extraction("Sucks blood from one foe."),
    valid_targets = { "hostile" },
    flags = { "TOUCH_REQUIRED", "NO_LEGS" },
    damage_type = "stab",
    min_damage = 5,
    max_damage = 10,
    damage_increment = 1.0,
    max_level = 5,
    min_range = 1,
    max_range = 2,
    range_increment = 0.2,
    effect = "attack",
    shape = "blast",
    extra_spells = { { spell = "light_healing", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bear_trap",
    name = ccb.content.text_without_extraction("Bear Trap"),
    description = ccb.content.text_without_extraction("A trap that summons bears!  Not what you were expecting, is it?"),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE" },
    min_damage = 3,
    max_damage = 3,
    min_aoe = 5,
    max_aoe = 5,
    sound_description = ccb.content.text("\"It's a trap!\""),
    min_duration = 30000,
    max_duration = 30000,
    sound_type = "speech",
    shape = "blast",
    effect = "summon",
    effect_data = "mon_bear",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "forge_trap",
    name = ccb.content.text_without_extraction("Forge Trap"),
    description = ccb.content.text_without_extraction("A trap that summons forge hounds!  Not what you were expecting, is it?"),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE" },
    min_damage = 3,
    max_damage = 3,
    min_aoe = 5,
    max_aoe = 5,
    sound_description = ccb.content.text("\"It's a trap!\""),
    min_duration = 30000,
    max_duration = 30000,
    sound_type = "speech",
    shape = "blast",
    effect = "summon",
    effect_data = "mon_forgehounds",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "rocket_punch",
    name = ccb.content.text_without_extraction("Rocket Punch"),
    description = ccb.content.text_without_extraction("Ejects giant fist from arm."),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS" },
    damage_type = "bash",
    min_damage = 30,
    max_damage = 40,
    damage_increment = 2.0,
    max_level = 5,
    min_range = 1,
    max_range = 2,
    range_increment = 0.2,
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_vengeance",
    name = ccb.content.text_without_extraction("Spirits of Vengeance"),
    description = ccb.content.text_without_extraction("Summons spirits of vengeance."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "PERMANENT" },
    effect = "summon",
    effect_data = "mon_spirit_vengeance",
    shape = "blast",
    max_level = 1,
    base_casting_time = 10,
    min_range = 20,
    max_range = 20,
    min_damage = 3,
    max_damage = 3,
    min_aoe = 6,
    max_aoe = 6,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_forgehounds",
    name = ccb.content.text_without_extraction("forgehounds"),
    description = ccb.content.text_without_extraction("Summons forgehounds."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "PERMANENT" },
    effect = "summon",
    effect_data = "mon_forgehounds",
    shape = "blast",
    max_level = 1,
    base_casting_time = 10,
    min_range = 20,
    max_range = 20,
    min_damage = 3,
    max_damage = 3,
    min_aoe = 6,
    max_aoe = 6,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_charge",
    name = ccb.content.text_without_extraction("Teleport Charge"),
    description = ccb.content.text_without_extraction("Edit all this tomorrow."),
    valid_targets = { "hostile", "ground" },
    flags = { "IGNORE_WALLS" },
    effect = "dash",
    effect_data = "downed",
    shape = "cone",
    min_damage = 0,
    max_damage = 35,
    damage_increment = 10,
    damage_type = "bash",
    min_range = 8,
    max_range = 8,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "prank",
    name = ccb.content.text_without_extraction("Leprechaun Prank"),
    description = ccb.content.text_without_extraction("Pranks the PC.  Gag humor."),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS" },
    max_level = 5,
    min_range = 1,
    max_range = 5,
    range_increment = 1,
    shape = "blast",
    effect = "vomit",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "gas_attack",
    name = ccb.content.text_without_extraction("Gas Attack"),
    description = ccb.content.text_without_extraction("Spreads toxic gas around itself."),
    valid_targets = { "self", "hostile", "ground" },
    flags = { "NO_HANDS", "NO_LEGS", "NO_PROJECTILE" },
    damage_type = "biological",
    min_damage = 1,
    max_damage = 1,
    max_level = 5,
    min_range = 1,
    max_range = 3,
    range_increment = 0.2,
    effect = "attack",
    shape = "blast",
    field = "fd_toxic_gas",
    field_chance = 10,
    min_field_intensity = 1,
    max_field_intensity = 1,
    min_duration = 1000,
    max_duration = 6000,
    duration_increment = 1000,
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 0.2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_demon_fireball",
    name = ccb.content.text_without_extraction("Demon Fireball"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    flags = { "IGNITE_FLAMMABLE", "SPLIT_DAMAGE", "RANDOM_DAMAGE" },
    valid_targets = { "hostile", "ground", "ally", "self" },
    min_damage = 45,
    max_damage = 90,
    min_range = 12,
    max_range = 12,
    min_aoe = 2,
    max_aoe = 2,
    base_casting_time = 120,
    effect = "attack",
    shape = "blast",
    damage_type = "heat",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_summon_demon_spiderlings",
    name = ccb.content.text_without_extraction("Summon Demon Spiderlings"),
    description = ccb.content.text_without_extraction("Summons 4 permanent demon spiderlings."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "NO_PROJECTILE" },
    valid_targets = { "ground" },
    min_damage = 4,
    max_damage = 4,
    min_range = 5,
    max_range = 5,
    min_aoe = 3,
    max_aoe = 3,
    base_casting_time = 160,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_demon_spiderling",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "burning_hands_monster",
    name = ccb.content.text_without_extraction("Burning Hands Monster"),
    description = ccb.content.text_without_extraction("Burning hands, if you're a monster."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "ally", "hostile", "ground" },
    flags = {
        "EVOCATION_SPELL",
        "RANDOM_DAMAGE",
        "SOMATIC",
        "VERBAL",
        "IGNITE_FLAMMABLE",
        "NO_HANDS",
        "SPLIT_DAMAGE",
    },
    extra_spells = { { spell = "eoc_evocation_setup", self = true } },
    max_level = 20,
    min_damage = 30,
    max_damage = 60,
    min_range = 3,
    max_range = 5,
    range_increment = 0.25,
    min_aoe = 25,
    max_aoe = 60,
    aoe_increment = 5.0,
    damage_type = "heat",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "demon_spider_fire_heal",
    name = ccb.content.text_without_extraction("Demon Spider Heal"),
    description = ccb.content.text_without_extraction("Drinks in flame and heals the demon spider."),
    flags = { "SILENT", "NO_PROJECTILE", "RANDOM_DAMAGE", "RANDOM_DURATION" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_demon_spider_speed",
    extra_spells = { { spell = "demon_spider_flame_drinking" } },
    min_damage = -15,
    max_damage = -80,
    min_duration = 300,
    max_duration = 800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "demon_spider_queen_fire_heal",
    name = ccb.content.text_without_extraction("Demon Spider Queen Heal"),
    description = ccb.content.text_without_extraction("Drinks in flame and heals the demon spider queen, as well as boosting her speed"),
    flags = { "SILENT", "NO_PROJECTILE", "RANDOM_DAMAGE", "RANDOM_DURATION" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_demon_spider_speed",
    extra_spells = { { spell = "demon_spider_flame_drinking" } },
    min_damage = -25,
    max_damage = -150,
    min_duration = 300,
    max_duration = 800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "demon_spider_flame_drinking",
    name = ccb.content.text_without_extraction("Demon Spider Flame Drinking"),
    description = ccb.content.text_without_extraction("Removes the flame field on the tile the demon spider is standing on."),
    flags = { "SILENT" },
    valid_targets = { "ground" },
    shape = "blast",
    effect = "ter_transform",
    effect_data = "ter_kelvinist_extinguish_transform",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "demon_breath_fire",
    name = ccb.content.text_without_extraction("Hellfire Belch"),
    description = ccb.content.text_without_extraction("Spits supernatural napalm from your mouth."),
    valid_targets = { "hostile", "ally", "ground" },
    damage_type = "heat",
    max_level = 30,
    min_damage = 6,
    max_damage = 180,
    damage_increment = 6.0,
    min_range = 8,
    max_range = 12,
    range_increment = 0.1,
    effect = "attack",
    shape = "line",
    flags = { "VERBAL", "NO_HANDS", "NO_LEGS", "SPLIT_DAMAGE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shambling_aoe",
    name = ccb.content.text_without_extraction("Shambling attack"),
    description = ccb.content.text_without_extraction("Devastating AoE attack.  You can see it only on debug mode."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    flags = { "RANDOM_DAMAGE", "RANDOM_AOE", "SPLIT_DAMAGE" },
    max_level = 0,
    min_damage = 15,
    max_damage = 70,
    min_range = 2,
    max_range = 2,
    min_aoe = 90,
    max_aoe = 270,
    damage_type = "bash",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_feral_wizard_base",
    name = ccb.content.text_without_extraction("Wild Magic Monster Sorcery"),
    description = ccb.content.text_without_extraction("Causes one of the spells to be cast, used for the feral wizard."),
    valid_targets = { "hostile" },
    effect = "none",
    shape = "blast",
    base_casting_time = 100,
    flags = { "WONDER", "NO_PROJECTILE" },
    min_damage = 1,
    max_damage = 1,
    min_range = 10,
    max_range = 10,
    message = "",
    extra_spells = {
        { spell = "blinding_flash" },
        { spell = "ethereal_grasp_monster" },
        { spell = "point_flare" },
        { spell = "dispel_magic_monster" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "monster_downed_stomp",
    name = ccb.content.text_without_extraction("Monster Downed Stomp"),
    description = ccb.content.text_without_extraction("The monster stomps on the ground and knocks anyone nearby off their feet."),
    valid_targets = { "hostile", "ground" },
    effect = "attack",
    effect_data = "downed",
    shape = "blast",
    max_level = 5,
    min_aoe = 1,
    max_aoe = 6,
    aoe_increment = 1,
    min_duration = 100,
    max_duration = 300,
    duration_increment = 40,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_troll_regenerate_limb_spell",
    name = ccb.content.text_without_extraction("Troll regenerate limbs"),
    description = ccb.content.text_without_extraction("Allows trolls to remove the maimed effect if their HP is high enough."),
    valid_targets = { "self" },
    effect = "remove_effect",
    effect_data = "maimed_arm",
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "monster_invisibility_spell",
    name = ccb.content.text_without_extraction("monster invisibility"),
    description = ccb.content.text_without_extraction("Makes the target invisible"),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "invisibility",
    shape = "blast",
    message = "",
    max_level = 35,
    min_duration = 1000,
    max_duration = 36000,
    duration_increment = 1000,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "monster_ranged_gas_attack",
    name = ccb.content.text_without_extraction("Gas Attack Ranged"),
    description = ccb.content.text_without_extraction("Spreads toxic gas around at range."),
    valid_targets = { "hostile" },
    flags = { "NO_PROJECTILE" },
    damage_type = "biological",
    min_damage = 1,
    max_damage = 1,
    max_level = 10,
    min_range = 3,
    max_range = 13,
    range_increment = 1,
    effect = "emit",
    effect_data = "emit_toxic_stream",
    shape = "blast",
    field = "fd_toxic_gas",
    field_chance = 1,
    min_field_intensity = 1,
    max_field_intensity = 1,
    min_aoe = 1,
    max_aoe = 5,
    aoe_increment = 0.5,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_bloodlust_spell",
    name = ccb.content.text_without_extraction("Bloodlust"),
    description = ccb.content.text_without_extraction("Speeds up an ally."),
    valid_targets = { "ally" },
    effect = "attack",
    shape = "blast",
    effect_data = "frenzy",
    max_level = 1,
    min_range = 10,
    max_range = 10,
    min_damage = 0,
    max_damage = 0,
    min_duration = 6000,
    max_duration = 12000,
    base_casting_time = 200,
    flags = { "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ankheg_acid_spit",
    name = ccb.content.text_without_extraction("Ankheg Acid Spit"),
    description = ccb.content.text_without_extraction("Spews a line of acid from your mouth."),
    valid_targets = { "hostile" },
    damage_type = "acid",
    max_level = 40,
    min_damage = 10,
    max_damage = 20,
    min_range = 8,
    max_range = 12,
    range_increment = 0.1,
    effect = "attack",
    extra_spells = { { spell = "ankheg_acid_spit_self", self = true } },
    shape = "line",
    field = "fd_acid",
    min_field_intensity = 1,
    max_field_intensity = 4,
    field_chance = 2,
    field_intensity_increment = 0.1,
    flags = { "RANDOM_DAMAGE", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ankheg_acid_spit_self",
    name = ccb.content.text_without_extraction("Ankheg Acid Spit Self"),
    description = ccb.content.text_without_extraction("Maims the ankheg's acid gland after spitting acid."),
    flags = { "RANDOM_DURATION", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "maimed_acid_gland",
    shape = "blast",
    min_duration = 720000,
    max_duration = 2160000,
}

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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "rust_monster_polymorph_to_hostile",
    name = ccb.content.text_without_extraction("[Ψ]Rust monster polymorph"),
    description = ccb.content.text_without_extraction("Rust monster polymorphing to hostile.  It's a bug if you have it."),
    message = "",
    valid_targets = { "self", "hostile", "ally" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "HIDDEN_SPELL" },
    difficulty = 8,
    max_level = 30,
    effect = "targeted_polymorph",
    effect_data = "mon_rust_monster_aggressive",
    shape = "blast",
    min_damage = 500,
    max_damage = 500,
    min_range = 10,
    max_range = 10,
    targeted_monsters = { "mon_rust_monster" },
}

ccb.content.define_spell {
    id = "will_o_wisp_draining_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Will o the Wisp draining attack"),
    description = ccb.content.text_without_extraction("The will o the Wisp life-draining attack."),
    flags = { "NO_LEGS", "SILENT", "NO_PROJECTILE", "SPLIT_DAMAGE" },
    valid_targets = { "hostile", "ally", "ground" },
    min_range = 3,
    impact_handler = "w16b_sp_imp_magiclysm_a462961d419e",
}

ccb.content.define_spell {
    id = "rust_monster_detect_metal_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("rust monster detect metal"),
    description = ccb.content.text_without_extraction("Rust monster detecting metal.  It's a bug if you have it."),
    message = "",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    valid_targets = { "ally", "hostile", "self" },
    min_aoe = 5,
    max_aoe = 5,
    impact_handler = "w16b_sp_imp_magiclysm_5332ae20b626",
}

ccb.content.define_spell {
    id = "rust_monster_increase_aggression",
    shape = "blast",
    name = ccb.content.text_without_extraction("[Ψ]Rust monster increase aggression"),
    description = ccb.content.text_without_extraction("Makes a hostile rust monster hostile again if you come back with more metal.  It's a bug if you have it."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "HIDDEN_SPELL" },
    valid_targets = { "self", "hostile", "ally" },
    targeted_monsters = { "mon_rust_monster" },
    min_range = 10,
    max_range = 10,
    difficulty = 8,
    max_level = 30,
    impact_handler = "w16b_sp_imp_magiclysm_c7c41b231122",
}

ccb.content.define_spell {
    id = "catoblepas_gaze_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("catoblepas gaze"),
    description = ccb.content.text_without_extraction("Does a big thwack of damage if the target can see the catoblepas"),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 15,
    max_range = 15,
    max_level = 20,
    impact_handler = "w16b_sp_imp_magiclysm_df42cb6e6d49",
}

ccb.content.define_spell {
    id = "feral_dabble_spell_selector_spell",
    shape = "blast",
    name = ccb.content.text_without_extraction("Dabbler Spell selector"),
    description = ccb.content.text_without_extraction("Random chance for a feral to have a single spell.  This picks a random spell."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "MUST_HAVE_CLASS_TO_LEARN", "HIDDEN_SPELL" },
    valid_targets = { "hostile" },
    min_range = 60,
    max_range = 60,
    max_level = 1,
    impact_handler = "w16b_sp_imp_magiclysm_256d41a1eb72",
}
