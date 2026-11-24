local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "lava_bomb_heat",
    name = ccb.content.text_without_extraction("Lava Bomb Heat"),
    description = ccb.content.text_without_extraction("This is a sub spell for the Lava Bomb spell."),
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "self", "ground" },
    damage_type = "heat",
    max_level = 35,
    min_damage = { handler = "scaled_lava_bomb_heat_min_damage", fallback = 1.0 },
    max_damage = { handler = "scaled_lava_bomb_heat_max_damage", fallback = 5.0 },
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "lava_bomb_ter",
    name = ccb.content.text_without_extraction("Lava Bomb Terrain"),
    description = ccb.content.text_without_extraction("This is a sub spell for the Lava Bomb spell."),
    effect = "ter_transform",
    effect_data = "lava_bomb",
    shape = "blast",
    max_level = 35,
    min_aoe = 0,
    max_aoe = 2,
    aoe_increment = 0.15,
    valid_targets = { "hostile", "ally", "self", "ground" },
}

-- The main part of the spell that causes all of the side effects.
ccb.content.define_spell {
    id = "lava_bomb_main",
    name = ccb.content.text("Lava Bomb"),
    description = ccb.content.text("You tear up the ground beneath you to fire a lava bomb: a globe of lava surrounded by hot, solid rock.  It shatters upon impact, spraying shards of rock and lava everywhere."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground", "ally" },
    damage_type = "bash",
    max_level = 35,
    difficulty = 6,
    min_damage = { handler = "scaled_lava_bomb_main_min_damage", fallback = 6.0 },
    max_damage = { handler = "scaled_lava_bomb_main_max_damage", fallback = 14.0 },
    min_range = 6,
    max_range = 10,
    range_increment = 0.2,
    base_casting_time = 350,
    base_energy_cost = 400,
    magic_type = "magiclysm_evocation_magic",
    flags = {
        "EVOCATION_SPELL",
        "RANDOM_DAMAGE",
        "VERBAL",
        "SOMATIC",
        "LOUD",
        "MUST_HAVE_CLASS_TO_LEARN",
        "SPLIT_DAMAGE",
    },
    extra_spells = {
        { spell = "lava_bomb_shrapnel" },
        { spell = "lava_bomb_heat" },
        { spell = "lava_bomb_ter" },
        { spell = "eoc_evocation_setup", self = true },
    },
    spell_class = "VULCANIST",
}

ccb.content.define_spell {
    id = "vulcanist_pyroclastic_flow",
    name = ccb.content.text("Pyroclastic Flow"),
    description = ccb.content.text("Pulls up the heat of the Earth, along with considerable smoke mixed with ashes."),
    effect = "attack",
    shape = "line",
    valid_targets = { "hostile", "ground", "ally" },
    damage_type = "heat",
    max_level = 35,
    difficulty = 10,
    min_damage = { handler = "scaled_vulcanist_pyroclastic_flow_min_damage", fallback = 21.0 },
    max_damage = { handler = "scaled_vulcanist_pyroclastic_flow_max_damage", fallback = 34.0 },
    min_range = 6,
    max_range = 16,
    range_increment = 0.3,
    min_aoe = 1,
    max_aoe = 7,
    aoe_increment = 0.25,
    base_casting_time = 350,
    base_energy_cost = 350,
    final_energy_cost = 500,
    energy_increment = 5,
    magic_type = "magiclysm_evocation_magic",
    flags = {
        "EVOCATION_SPELL",
        "RANDOM_DAMAGE",
        "VERBAL",
        "SOMATIC",
        "LOUD",
        "IGNITE_FLAMMABLE",
        "SPLIT_DAMAGE",
    },
    extra_spells = {
        { spell = "vulcanist_pyroclastic_flow_smoke" },
        { spell = "eoc_evocation_setup", self = true },
    },
    spell_class = "VULCANIST",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vulcanist_pyroclastic_flow_smoke",
    name = ccb.content.text_without_extraction("Pyroclastic Flow Smoke"),
    description = ccb.content.text_without_extraction("Creates smoke in the area.  Subspell; you aren't allowed to see it except in debug mode."),
    effect = "attack",
    shape = "line",
    valid_targets = { "hostile", "ground", "ally" },
    field = "fd_fog",
    max_level = 35,
    min_field_intensity = 1,
    max_field_intensity = 3,
    field_intensity_increment = 2,
    min_aoe = 3,
    max_aoe = 7,
    aoe_increment = 0.12,
}

ccb.content.define_spell {
    id = "lava_bomb_shrapnel",
    shape = "blast",
    effect = "attack",
    damage_type = "cut",
    name = ccb.content.text_without_extraction("Lava Bomb Shrapnel"),
    description = ccb.content.text_without_extraction("This is a sub spell for the Lava Bomb spell."),
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE" },
    valid_targets = { "hostile", "ally", "self", "ground" },
    min_damage = { handler = "wave14a_magiclysm_stat_22", fallback = 0 },
    max_damage = { handler = "wave14a_magiclysm_stat_23", fallback = 0 },
    min_aoe = 1,
    aoe_increment = 0.1,
    max_aoe = 3,
    multiple_projectiles = { handler = "wave14a_magiclysm_stat_10", fallback = 0 },
    max_level = 35,
}
