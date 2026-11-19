local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_grass_field_monster",
    name = ccb.content.text_without_extraction("Commanding the Grasses Monster"),
    description = ccb.content.text_without_extraction("Grow grass in an instant, if you are a monster."),
    valid_targets = { "hostile", "ground" },
    flags = { "VERBAL", "SOMATIC", "NO_PROJECTILE", "NO_HANDS", "NO_LEGS" },
    max_level = 20,
    skill = "deduction",
    teachable = false,
    difficulty = 1,
    effect = "ter_transform",
    effect_data = "ter_arvore_command_grasses",
    shape = "blast",
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_aoe = 1,
    max_aoe = 10,
    aoe_increment = 0.25,
    magic_type = "xedra_arvore_magick",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_solar_spirit_triffid_monster",
    name = ccb.content.text_without_extraction("Summon solar spirit"),
    description = ccb.content.text_without_extraction("Summons a solar spirit if you are a triffid."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self", "hostile" },
    effect = "summon",
    effect_data = "mon_solar_spirit_triffid_summon",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_aoe = 4,
    max_aoe = 4,
    min_duration = 5000,
    max_duration = 5000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "summon_vinebeast_triffid_monster",
    name = ccb.content.text_without_extraction("Summon vinebeast"),
    description = ccb.content.text_without_extraction("Summons a vinebeast if you are a triffid."),
    flags = { "HOSTILE_SUMMON", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self", "hostile" },
    max_level = 20,
    effect = "summon",
    effect_data = "mon_vinebeast_summon",
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    min_aoe = 4,
    max_aoe = 4,
    min_range = 5,
    max_range = 25,
    range_increment = 1,
    min_duration = 4000,
    max_duration = 4000,
}
