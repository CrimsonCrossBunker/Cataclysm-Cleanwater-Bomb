local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hoary_blast_march_lord",
    name = ccb.content.text_without_extraction("Hoary Blast"),
    description = ccb.content.text_without_extraction("You project a glowing white crystal of ice and it explodes on impact into a blossom of shattering cold."),
    effect = "attack",
    shape = "line",
    valid_targets = { "self", "ally", "hostile", "ground" },
    extra_spells = { { spell = "hoary_blast_march_lord_non_torso" } },
    flags = { "LOUD", "RANDOM_DAMAGE" },
    max_level = 20,
    min_damage = 8,
    max_damage = 24,
    min_aoe = 3,
    max_aoe = 3,
    min_range = 7,
    max_range = 7,
    field = "fd_cold_air4",
    field_chance = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
    damage_type = "cold",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hoary_blast_march_lord_non_torso",
    name = ccb.content.text_without_extraction("Hoary Blast Non Torso"),
    description = ccb.content.text_without_extraction("The Second Hoary Blast that only hits limbs, to ensure we don't double-hit a torso."),
    effect = "attack",
    shape = "line",
    valid_targets = { "self", "ally", "hostile", "ground" },
    affected_bodyparts = { "head", "tail", "arm_l", "arm_r", "leg_l", "leg_r" },
    flags = { "LOUD", "RANDOM_DAMAGE" },
    max_level = 20,
    min_damage = 8,
    max_damage = 24,
    damage_type = "cold",
    min_aoe = 3,
    max_aoe = 3,
    min_range = 7,
    max_range = 7,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_salamander_glob",
    name = ccb.content.text_without_extraction("Salamander Glob"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    flags = { "IGNITE_FLAMMABLE" },
    valid_targets = { "hostile", "ground", "ally", "self" },
    min_damage = 5,
    max_damage = 5,
    min_range = 6,
    max_range = 6,
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
    id = "mon_arvore_roots_spell",
    name = ccb.content.text_without_extraction("Hungry Thirsty Roots Monster"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    max_level = 20,
    teachable = false,
    effect = "attack",
    effect_data = "effect_hungry_roots",
    shape = "blast",
    damage_type = "bash",
    min_aoe = 0,
    max_aoe = 3,
    aoe_increment = 0.25,
    min_range = 4,
    max_range = 15,
    range_increment = 1,
    min_duration = 500,
    max_duration = 2000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_shamir_dig_spell",
    name = ccb.content.text_without_extraction("Shamir Dig Pit Spell"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    message = "",
    teachable = false,
    valid_targets = { "ground", "hostile" },
    effect = "ter_transform",
    effect_data = "ierde_create_pits_transform",
    shape = "blast",
    min_range = 10,
    max_range = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_sheyd_eye_evil_spell",
    name = ccb.content.text_without_extraction("Sheyd Evil Eye Spell"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    message = "",
    teachable = false,
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "ground", "hostile" },
    effect = "attack",
    effect_data = "effect_evil_eye",
    shape = "blast",
    min_range = 15,
    max_range = 15,
    min_duration = 15000,
    max_duration = 180000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_flaming_eye_evil_spell",
    name = ccb.content.text_without_extraction("Flaming Eye Evil Eye Spell"),
    description = ccb.content.text_without_extraction("This is a monster only spell."),
    message = "",
    teachable = false,
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "ground", "hostile" },
    effect = "attack",
    effect_data = "effect_evil_eye",
    shape = "blast",
    min_range = 40,
    max_range = 40,
    min_duration = 360000,
    max_duration = 1080000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_shabriri_blind_spell",
    name = ccb.content.text_without_extraction("Shabriri Blinding Spell"),
    description = ccb.content.text_without_extraction("This is a monster only spell.  My mother told me, Shabriri bariri riri iri ri, in my white cup."),
    message = "",
    teachable = false,
    flags = { "NO_PROJECTILE", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    extra_spells = { { spell = "mon_shabriri_blind_spell_reduce_anger", self = true } },
    valid_targets = { "ground", "hostile" },
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    min_range = 20,
    max_range = 20,
    min_duration = 3000,
    max_duration = 30000,
}
