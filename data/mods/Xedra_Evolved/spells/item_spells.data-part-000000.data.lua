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
