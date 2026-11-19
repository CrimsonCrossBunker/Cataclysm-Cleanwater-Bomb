local ccb = require("ccb")

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
