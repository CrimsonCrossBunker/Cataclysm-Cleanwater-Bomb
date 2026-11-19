local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- duration is in moves
ccb.content.define_spell {
    id = "overcharge_yrax",
    name = ccb.content.text_without_extraction("▙▜▛▘▜▝▞▟▘▜"),
    description = ccb.content.text_without_extraction(" ▘▙▚▛▜▝▞▟"),
    valid_targets = { "self", "ally", "hostile" },
    targeted_monsters = { "mon_yrax_delta", "mon_yrax_quadraphract" },
    flags = { "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "yrax_overcharged",
    shape = "blast",
    affected_bodyparts = { "torso" },
    base_casting_time = 100,
    base_energy_cost = 100,
    energy_source = "MANA",
    difficulty = 1,
    max_level = 1,
    min_aoe = 40,
    max_aoe = 40,
    min_range = 10,
    max_range = 10,
    min_duration = 500,
    max_duration = 500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "activate_yrax",
    name = ccb.content.text_without_extraction("Base activate Yrax"),
    description = ccb.content.text_without_extraction("Base spell for Yrax (de)activation."),
    valid_targets = { "hostile", "ally", "self" },
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "targeted_polymorph",
    effect_data = "",
    shape = "blast",
    base_casting_time = 15,
    max_level = 1,
    min_damage = 10000000,
    max_damage = 10000000,
    damage_type = "pure",
    min_aoe = 50,
    max_aoe = 50,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "quadraphract_smoke_mortar",
    name = ccb.content.text_without_extraction("Quadraphract Smoke Mortar"),
    description = ccb.content.text_without_extraction("Throws several smoke bombs in a large area and with high scatter."),
    extra_spells = {
        { spell = "quadraphract_smoke_bomb_repeat" },
        { spell = "quadraphract_smoke_bomb_repeat" },
        { spell = "quadraphract_smoke_bomb_repeat" },
        { spell = "quadraphract_smoke_bomb_repeat" },
        { spell = "quadraphract_smoke_bomb_repeat" },
    },
    valid_targets = { "hostile", "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    damage_type = "bash",
    min_damage = 1,
    max_damage = 5,
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE" },
    base_casting_time = 100,
    min_aoe = 4,
    max_aoe = 8,
    min_range = 40,
    max_range = 40,
    explosion_light = "smoke_cloud",
    field = "fd_smoke",
    field_chance = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "quadraphract_smoke_bomb_repeat",
    name = ccb.content.text_without_extraction("Quadraphract Smoke Mortar - repeat"),
    description = ccb.content.text_without_extraction("A single bomblet from the mortar strike."),
    valid_targets = { "hostile", "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    message = "",
    damage_type = "bash",
    min_damage = 1,
    max_damage = 5,
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_DAMAGE", "RANDOM_AOE" },
    base_casting_time = 100,
    min_aoe = 4,
    max_aoe = 8,
    min_range = 40,
    max_range = 6,
    explosion_light = "smoke_cloud",
    field = "fd_smoke",
    field_chance = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sphenocorona_active",
    name = ccb.content.text_without_extraction("Activate Sphenocorona"),
    description = ccb.content.text_without_extraction("Golden monoliths to Sphenocoronae."),
    copy_from = "activate_yrax",
    targeted_monsters = { "mon_golden_monolith" },
    effect_data = "mon_yrax_sphenocorona",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sphenocorona_inactive",
    name = ccb.content.text_without_extraction("Activate Sphenocorona"),
    description = ccb.content.text_without_extraction("Sphenocoronae to Golden monoliths."),
    copy_from = "activate_yrax",
    targeted_monsters = { "mon_yrax_sphenocorona" },
    effect_data = "mon_golden_monolith",
}

-- NO_I18N
-- NO_I18N
-- make sure to only summon a prime number of deltas or I'll be mad
ccb.content.define_spell {
    id = "release_the_deltas",
    name = ccb.content.text_without_extraction("Release the deltas!"),
    description = ccb.content.text_without_extraction("Summons a varying amount of Yrax deltas."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 2,
    max_damage = 23,
    damage_increment = 1,
    max_level = 21,
    min_aoe = 2,
    max_aoe = 2,
    base_casting_time = 500,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_yrax_delta",
}
