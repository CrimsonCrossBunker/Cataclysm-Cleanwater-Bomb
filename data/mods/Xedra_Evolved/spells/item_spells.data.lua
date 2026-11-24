local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "kantele_spell",
    name = ccb.content.text_without_extraction("Väinämöinen's Kantele Song"),
    description = ccb.content.text_without_extraction("You play and sing songs written by or about a Finnish wizard/deity.  It summons forest mammals to your presence."),
    valid_targets = { "ground" },
    skill = "deduction",
    min_damage = 1,
    max_damage = 8,
    damage_increment = 0.5,
    min_range = 3,
    max_range = 18,
    range_increment = 1,
    max_level = 15,
    difficulty = 3,
    effect = "summon",
    effect_data = "GROUP_WILDERNESS_FOREST_MAMMAL",
    shape = "blast",
    magic_type = "xedra_magic_generic",
    base_energy_cost = 500,
    energy_increment = 20,
    final_energy_cost = 300,
    min_aoe = 3,
    max_aoe = 18,
    aoe_increment = 1,
    base_casting_time = 30000,
    casting_time_increment = 500,
    final_casting_time = 22500,
    flags = { "SOMATIC", "VERBAL", "SPAWN_GROUP", "PERMANENT_ALL_LEVELS" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nine_second_time_stop",
    name = ccb.content.text_without_extraction("Nine more seconds"),
    description = ccb.content.text_without_extraction("Nine seconds of time stop for what I assume is a mythological reference."),
    message = ccb.content.text("Time suddenly stops for everything but you."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "mod_moves",
    shape = "blast",
    min_damage = 900,
    max_damage = 900,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_dreamsmith_time_stop",
    name = ccb.content.text_without_extraction("Pocketwatch stop"),
    description = ccb.content.text_without_extraction("Stops time for 10 seconds.  Having this spell is a bug."),
    message = ccb.content.text("Time suddenly stops for everything but you."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "mod_moves",
    shape = "blast",
    min_damage = 1000,
    max_damage = 1000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spawn_milk_and_hazelnuts",
    name = ccb.content.text_without_extraction("Milk and Hazelnuts"),
    description = ccb.content.text_without_extraction("Spawns milk.  The extra effect spawns the hazelnuts."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "PERMANENT", "NO_LEGS", "NO_EXPLOSION_SFX", "NO_PROJECTILE" },
    difficulty = 1,
    min_damage = 2,
    max_damage = 2,
    duration_increment = 1,
    effect = "spawn_item",
    effect_data = "milk",
    shape = "blast",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 0,
    final_casting_time = 0,
    extra_spells = { { spell = "spawn_hazelnuts" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spawn_hazelnuts",
    name = ccb.content.text_without_extraction("Here's the Hazelnuts"),
    description = ccb.content.text_without_extraction("This extra effect spawns the hazelnuts."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "PERMANENT", "NO_LEGS", "NO_EXPLOSION_SFX", "NO_PROJECTILE" },
    difficulty = 1,
    min_damage = 2,
    max_damage = 2,
    duration_increment = 1,
    effect = "spawn_item",
    effect_data = "hazelnut_shelled",
    shape = "blast",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 0,
    final_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "potion_recover_mana_xe",
    name = ccb.content.text_without_extraction("Recover Mana"),
    description = ccb.content.text_without_extraction("You regain mana."),
    valid_targets = { "self" },
    min_damage = 250,
    damage_increment = 50.0,
    max_damage = 2000,
    max_level = 35,
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    spell_class = "NONE",
    message = ccb.content.text("You start regenerating mana!"),
    magic_type = "xedra_magic_generic",
    base_energy_cost = 0,
    energy_increment = 0,
    final_energy_cost = 0,
    flags = { "SILENT", "NO_LEGS" },
    difficulty = 3,
}

-- NO_I18N
-- Used for blackout rage drink, not castable.
-- NO_I18N
ccb.content.define_spell {
    id = "blackout_rage_drink",
    name = ccb.content.text_without_extraction("Blackout rage drank"),
    description = ccb.content.text_without_extraction("This spell transforms you into a drunken master."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
    effect = "spawn_item",
    effect_data = "aura_drunken_master",
    shape = "blast",
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    damage_increment = 0,
    damage_type = "biological",
    difficulty = 0,
    spell_class = "NONE",
    base_casting_time = 300,
    base_energy_cost = 2,
    min_duration = 432000,
    max_duration = 432000,
}

-- NO_I18N
-- Used for the cosmic dagwood inventor item, not castable
-- NO_I18N
ccb.content.define_spell {
    id = "cosmic_dagwood_regeneration",
    name = ccb.content.text_without_extraction("rejuvenation"),
    description = ccb.content.text_without_extraction("This spell regenerates health (limb health) for a short period"),
    valid_targets = { "self" },
    base_energy_cost = 0,
    energy_increment = 0,
    final_energy_cost = 0,
    flags = { "SILENT", "NO_LEGS", "SPLIT_DAMAGE" },
    difficulty = 0,
    shape = "blast",
    message = ccb.content.text("The sandwich is a flavor beyond time and space, and as you lick your fingers clean you feel your youth return to you - Wait, no, Your wounds are just healing."),
    effect = "attack",
    spell_class = "NONE",
    min_dot = -10,
    max_dot = -10,
    min_duration = 1500,
    max_duration = 1500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bio_explosion",
    name = ccb.content.text_without_extraction("Biotic Blast"),
    description = ccb.content.text_without_extraction("Explode the enemy.  Literally."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "self" },
    flags = { "LOUD", "NO_LEGS", "RANDOM_DAMAGE" },
    min_damage = 560,
    max_damage = 700,
    min_aoe = 17,
    max_aoe = 17,
    min_range = 60,
    max_range = 60,
    damage_type = "biological",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ion_shot_1",
    name = ccb.content.text_without_extraction("Ion Shot"),
    description = ccb.content.text_without_extraction("A small ion charge."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "LOUD", "RANDOM_DAMAGE" },
    min_damage = 40,
    max_damage = 60,
    min_range = 30,
    max_range = 30,
    damage_type = "electric",
    extra_spells = { { spell = "ion_shot_2", max_level = 0 } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ion_shot_2",
    name = ccb.content.text_without_extraction("Secondary Ion Shot"),
    description = ccb.content.text_without_extraction("A small ion charge."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_TARGET" },
    min_damage = 40,
    max_damage = 60,
    min_range = 4,
    max_range = 4,
    damage_type = "electric",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "heat_expl_gun",
    name = ccb.content.text_without_extraction("Instant Ignition"),
    description = ccb.content.text_without_extraction("Explode a small area."),
    effect = "explosion",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "IGNORE_WALLS", "NO_PROJECTILE" },
    min_damage = 120,
    max_damage = 180,
    min_range = 30,
    max_range = 30,
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "jump_boots_leap",
    name = ccb.content.text_without_extraction("Jump Boots Leap"),
    description = ccb.content.text_without_extraction("Makes you jump."),
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    effect = "dash",
    shape = "cone",
    damage_type = "bash",
    min_range = 11,
    max_range = 11,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "inventor_electric_fist_spell",
    name = ccb.content.text_without_extraction("Overture Electric Attack"),
    description = ccb.content.text_without_extraction("You cast an electric spell at the monster."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NON_MAGICAL", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    min_damage = 18,
    max_damage = 29,
    damage_type = "electric",
    min_range = 1,
    max_range = 1,
    shape = "blast",
    effect = "attack",
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 1,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "learn_blood_of_saints",
    name = ccb.content.text_without_extraction("Blood of Saints"),
    description = ccb.content.text_without_extraction("This grants a specific mutation."),
    effect = "mutate",
    shape = "blast",
    effect_data = "BLOOD_OF_SAINTS",
    message = ccb.content.text("You imbibed the concoction and you feel your veins flex in a warm glow."),
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "extend_life",
    name = ccb.content.text_without_extraction("Extend Life"),
    description = ccb.content.text_without_extraction("This grants a specific mutation."),
    effect = "mutate",
    shape = "blast",
    effect_data = "EXTEND_LIFE",
    message = ccb.content.text("You imbibed the concoction and you feel your chakras align and your DNA de-age."),
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "future_sight",
    name = ccb.content.text_without_extraction("Future Sight"),
    description = ccb.content.text_without_extraction("Summons an aura that grants precognitive abilities."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
    effect = "spawn_item",
    effect_data = "aura_futuresight",
    shape = "blast",
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    damage_increment = 0,
    damage_type = "biological",
    difficulty = 0,
    spell_class = "NONE",
    base_casting_time = 300,
    base_energy_cost = 2,
    min_duration = 4320000,
    max_duration = 4320000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hyde_formula",
    name = ccb.content.text_without_extraction("Hyde Formula"),
    description = ccb.content.text_without_extraction("This grants a specific mutation."),
    effect = "mutate",
    shape = "blast",
    effect_data = "HYDE",
    message = ccb.content.text("You imbibed the concoction and you feel your inner self unleashed."),
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wicked_quick_hands",
    name = ccb.content.text_without_extraction("Wicked Quick Hands"),
    description = ccb.content.text_without_extraction("You become more graceful, agile, and coordinated."),
    valid_targets = { "self" },
    min_duration = 360000,
    max_duration = 360000,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    effect_data = "wicked_quick_hands",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "terrible_strength",
    name = ccb.content.text_without_extraction("Terrible Strength"),
    description = ccb.content.text_without_extraction("You gain a terrible strength."),
    valid_targets = { "self" },
    min_duration = 360000,
    max_duration = 360000,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    effect_data = "terrible_strength",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_hare_leap",
    name = ccb.content.text_without_extraction("Hare Leap"),
    description = ccb.content.text_without_extraction("You squat down, build up tension in your legs and release, launching yourself quite a distance."),
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    effect = "dash",
    shape = "cone",
    min_range = 8,
    max_range = 8,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dream_drainer_maker_real",
    name = ccb.content.text_without_extraction("Create the dream-drainer real"),
    description = ccb.content.text_without_extraction("Transform a mosquito into a dream-draining nightmare."),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "NO_PROJECTILE" },
    effect = "targeted_polymorph",
    effect_data = "mon_dream_drainer_mosquito",
    shape = "blast",
    spell_class = "NONE",
    base_casting_time = 10,
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
    id = "rip_ticket",
    name = ccb.content.text_without_extraction("Rip"),
    description = ccb.content.text_without_extraction("You hear an otherworldly slice."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = {
        "SILENT",
        "NO_EXPLOSION_SFX",
        "NO_FAIL",
        "NO_HANDS",
        "NO_LEGS",
        "NON_MAGICAL",
        "RANDOM_DAMAGE",
        "RANDOM_TARGET",
    },
    min_damage = 80,
    max_damage = 100,
    min_range = 9,
    max_range = 9,
    damage_type = "cut",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "netherium_warp_grenade_detonation",
    name = ccb.content.text_without_extraction("Netherium Warp Detonation"),
    description = ccb.content.text_without_extraction("Having this spell is a bug.  And casting it is lethal"),
    message = ccb.content.text("The location the grenade occupied is instantly overwhelmed with sounds and colors you've never felt before as space warps in impossible ways.  Whatever used to be there is now gone."),
    effect = "attack",
    extra_spells = { { spell = "netherium_warp_grenade_detonation_portal", max_level = 0 } },
    shape = "blast",
    valid_targets = { "self", "hostile", "ally", "ground" },
    min_damage = 1000,
    max_damage = 1000,
    min_bash_scaling = 10,
    min_aoe = 2,
    max_aoe = 5,
    damage_type = "pure",
    flags = {
        "NO_FAIL",
        "NO_HANDS",
        "NO_LEGS",
        "NON_MAGICAL",
        "RANDOM_AOE",
        "PERCENTAGE_DAMAGE",
        "IGNORE_WALLS",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "netherium_warp_grenade_detonation_portal",
    name = ccb.content.text_without_extraction("Netherium Warp Detonation - Portal"),
    description = ccb.content.text_without_extraction("Having this spell is a bug.  Has a 50% chance to spawn a reality tear"),
    effect = "attack",
    shape = "blast",
    field = "fd_fatigue",
    field_chance = 2,
    min_field_intensity = 10,
    max_field_intensity = 10,
    valid_targets = { "ground", "self", "ally", "hostile", "field", "item", "none" },
    flags = { "NO_FAIL", "NO_HANDS", "NO_LEGS", "NON_MAGICAL" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "inventor_portal_closer_spell",
    name = ccb.content.text_without_extraction("Netherium-Reality Smooth"),
    description = ccb.content.text_without_extraction("Having this spell is a bug.  Will remove tears in reality and other portals with side effects."),
    message = ccb.content.text("The two halves of the smoother surge together, forcing the teleporters together with a massive clang!  Due to your precise engineering the teleporters activate at the exact moment of impact, temporarily shunting them into the nether and unleashing a massive cascade of netherium energy that ripples around you."),
    effect = "ter_transform",
    effect_data = "inventor_portal_closer_spell_furn_transform",
    extra_spells = { { spell = "inventor_portal_closer_spell_portal_storm", max_level = 0, self = true } },
    shape = "blast",
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    min_range = 1,
    max_range = 1,
    flags = { "NO_FAIL", "NO_HANDS", "NO_LEGS", "NON_MAGICAL", "IGNORE_WALLS" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_inventor_time_pierce",
    name = ccb.content.text_without_extraction("Inventor Time Pierce"),
    description = ccb.content.text_without_extraction("Used by a time piercer to fix frozen time areas.  Having this spell is a bug."),
    teachable = false,
    valid_targets = { "self", "ally", "ground", "hostile" },
    flags = { "SILENT", "NO_LEGS", "NO_EXPLOSION_SFX", "NON_MAGICAL", "NO_FAIL" },
    difficulty = 0,
    max_level = 1,
    effect = "ter_transform",
    effect_data = "xedra_inventor_time_pierce_furn_transform",
    extra_spells = { { spell = "xedra_inventor_time_pierce_creature" } },
    shape = "blast",
    min_range = 1,
    max_range = 1,
    energy_source = "NONE",
    base_energy_cost = 0,
    final_energy_cost = 0,
    energy_increment = 0,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_inventor_time_pierce_creature",
    name = ccb.content.text_without_extraction("Inventor Time Pierce - Creature"),
    description = ccb.content.text_without_extraction("Used by a time piercer to fix time frozen creatures.  Having this spell is a bug."),
    teachable = false,
    valid_targets = { "self", "ally", "hostile" },
    flags = { "SILENT", "NO_LEGS", "NO_EXPLOSION_SFX", "NON_MAGICAL", "NO_FAIL" },
    difficulty = 0,
    max_level = 1,
    effect = "remove_effect",
    effect_data = "effect_xedra_time_freeze",
    shape = "blast",
    min_range = 1,
    max_range = 1,
    energy_source = "NONE",
    base_energy_cost = 0,
    final_energy_cost = 0,
    energy_increment = 0,
    base_casting_time = 100,
}

ccb.content.define_spell {
    id = "xedra_dreamsmith_time_trap_freeze",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "effect_xedra_time_freeze",
    name = ccb.content.text_without_extraction("Time Freeze"),
    description = ccb.content.text_without_extraction("Freezes the target in time.  Having this spell is a bug."),
    teachable = false,
    flags = { "NO_FAIL", "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE" },
    valid_targets = { "hostile", "ground", "ally" },
    energy_source = "NONE",
    min_range = 1,
    max_range = 1,
    min_duration = 1440000,
    max_duration = 1440000,
    base_energy_cost = 0,
    difficulty = 0,
    max_level = 1,
    base_casting_time = 0,
    extra_spells = {
        {
            spell = "xedra_dreamsmith_time_trap_freeze_spawn_trap",
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_dreamsmith_time_trap_freeze_spawn_trap",
    name = ccb.content.text_without_extraction("Time Freeze - Spawn Trap"),
    description = ccb.content.text_without_extraction("Spawns the trap after it is used.  Having this spell is a bug."),
    teachable = false,
    valid_targets = { "ground" },
    skill = "deduction",
    flags = { "NO_FAIL", "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "PERMANENT_ALL_LEVELS" },
    difficulty = 0,
    max_level = 1,
    effect = "spawn_item",
    effect_data = "xedra_dreamsmith_time_trap",
    shape = "blast",
    min_range = 1,
    max_range = 1,
    energy_source = "NONE",
    base_energy_cost = 0,
    base_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boann_unique_weapon_sword_onhit_blind",
    name = ccb.content.text_without_extraction("Sidereal Eclipse blind"),
    description = ccb.content.text_without_extraction("Targets you hit are blinded."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "blind",
    min_duration = 200,
    max_duration = 600,
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_blind_flash",
    name = ccb.content.text_without_extraction("Flash fruit"),
    description = ccb.content.text_without_extraction("Produces the fruit's flash effect when eaten.  You're not supposed to see this, the same way your foes aren't supposed to see after you ate that fruit near them."),
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    affected_bodyparts = { "eyes" },
    valid_targets = { "self", "ground" },
    min_aoe = 7,
    max_aoe = 7,
    min_range = 1,
    max_range = 1,
    min_duration = 2000,
    max_duration = 2500,
    spell_class = "NONE",
    flags = { "SILENT", "NO_FAIL", "NO_LEGS", "NO_PROJECTILE" },
    difficulty = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_heat_blasts",
    name = ccb.content.text_without_extraction("Fruit blast"),
    description = ccb.content.text_without_extraction("Cast heat beams in random directions."),
    valid_targets = { "self" },
    flags = { "WONDER" },
    effect = "attack",
    shape = "blast",
    message = ccb.content.text("Fiery needles emerge from your body and surge towards anything vaguely hostile."),
    min_damage = 25,
    max_damage = 25,
    min_range = 0,
    max_range = 0,
    extra_spells = { { spell = "goblin_fruit_heat_blast" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_heat_blast",
    name = ccb.content.text_without_extraction("Heat beam"),
    description = ccb.content.text_without_extraction("Uncontrolled heat blast."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_TARGET", "RANDOM_DAMAGE", "SILENT" },
    effect = "attack",
    shape = "blast",
    message = "",
    min_damage = 10,
    max_damage = 20,
    damage_type = "heat",
    min_range = 7,
    max_range = 7,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "goblin_fruit_map_reveal",
    name = ccb.content.text_without_extraction("Goblin fruit map reveal"),
    description = ccb.content.text_without_extraction("Reveal map when you eat a goblin fruit.  You must not see this."),
    teachable = false,
    valid_targets = { "none" },
    spell_class = "NONE",
    flags = { "NO_HANDS", "NO_FAIL", "SILENT", "NO_LEGS" },
    difficulty = 0,
    max_level = 0,
    effect = "map",
    shape = "blast",
    min_aoe = 15,
    max_aoe = 15,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bezoar_vomit",
    name = ccb.content.text_without_extraction("Bezoar Vomit"),
    valid_targets = { "self" },
    description = ccb.content.text_without_extraction("Vomits when you consume a second bezoar."),
    flags = { "SILENT" },
    effect = "vomit",
    shape = "blast",
}

ccb.content.define_spell {
    id = "mace_pipe_magic_throw",
    shape = "blast",
    effect = "attack",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Throw The Hammer"),
    description = ccb.content.text_without_extraction("You throw the hammer."),
    flags = { "SOMATIC", "SILENT", "NON_MAGICAL", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_406", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_407", fallback = 0 },
    min_range = { handler = "wave14a_xedra_evolved_stat_408", fallback = 0 },
    max_range = { handler = "wave14a_xedra_evolved_stat_408", fallback = 0 },
}

ccb.content.define_spell {
    id = "dream_drainer_maker",
    skill = "deduction",
    shape = "blast",
    spell_class = "NONE",
    name = ccb.content.text_without_extraction("Create the dream-drainer"),
    description = ccb.content.text_without_extraction("This spell is used by the catalyst to summon the dream-drainer.  It's not intended to be known by the player."),
    message = "",
    teachable = false,
    flags = { "NO_HANDS", "SILENT", "NO_FAIL" },
    valid_targets = { "hostile", "ally" },
    targeted_monsters = { "mon_mosquito_small", "mon_mosquito_giant", "mon_mosquito_mega", "mon_mosquito_larva" },
    min_range = 5,
    max_range = 5,
    difficulty = 0,
    base_casting_time = 5,
    impact_handler = "w16b_sp_imp_xedra_evolved_47a46d654d4d",
}
