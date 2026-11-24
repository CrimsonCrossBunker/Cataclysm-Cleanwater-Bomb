local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "immolate_transform",
    name = ccb.content.text_without_extraction("Immolate Transform"),
    description = ccb.content.text_without_extraction("The part of the Immolate spell that causes the transform."),
    valid_targets = { "ally", "hostile", "ground" },
    effect = "ter_transform",
    effect_data = "immolate_transform",
    shape = "blast",
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.07,
}

ccb.content.define_spell {
    id = "immolate",
    name = ccb.content.text("Immolate"),
    description = ccb.content.text("A purifying blast of raw elemental heat wipes the slate clean, searing the Earth back to her most original state: a barren ball of burning rock."),
    valid_targets = { "ally", "hostile", "ground" },
    flags = {
        "EVOCATION_SPELL",
        "SOMATIC",
        "VERBAL",
        "NO_LEGS",
        "LOUD",
        "RANDOM_DAMAGE",
        "CONCENTRATE",
        "IGNITE_FLAMMABLE",
        "MUST_HAVE_CLASS_TO_LEARN",
        "NO_HANDS",
        "SPLIT_DAMAGE",
    },
    effect = "attack",
    shape = "blast",
    extra_spells = {
        { spell = "immolate_transform" },
        { spell = "immolate_push" },
        { spell = "eoc_evocation_setup", self = true },
    },
    damage_type = "heat",
    min_damage = { handler = "scaled_immolate_min_damage", fallback = 61.0 },
    max_damage = { handler = "scaled_immolate_max_damage", fallback = 79.0 },
    min_range = 4,
    max_range = 8,
    range_increment = 0.12,
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.07,
    base_energy_cost = 520,
    spell_class = "CLEANSING_FLAME",
    difficulty = 4,
    max_level = 35,
    base_casting_time = 390,
    sound_description = ccb.content.text("a searing whoosh"),
    magic_type = "magiclysm_evocation_magic",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "immolate_push",
    name = ccb.content.text_without_extraction("Immolate Push Effect"),
    description = ccb.content.text_without_extraction("The immolate spell is powerful enough to push targets from its epicenter."),
    effect = "directed_push",
    shape = "blast",
    valid_targets = { "ally", "hostile", "ground" },
    max_level = 35,
    min_damage = 0,
    max_damage = 2,
    damage_increment = 0.07,
    min_aoe = 1,
    max_aoe = 3,
    aoe_increment = 0.07,
    min_range = 4,
    max_range = 8,
    range_increment = 0.12,
}

-- Well that's too edgy now, need to replace it.
ccb.content.define_spell {
    id = "cleansingflame_hermes_heal",
    spell_class = "CLEANSING_FLAME",
    name = ccb.content.text("Hermes Reborn"),
    description = ccb.content.text("In the sea without lees\nStandeth the bird of Hermes\nEating his wings variable\nAnd maketh himself yet full stable"),
    valid_targets = { "self" },
    effect = "attack",
    shape = "blast",
    base_casting_time = 350,
    base_energy_cost = 800,
    magic_type = "magiclysm_restoration_magic",
    difficulty = 10,
    min_damage = { handler = "scaled_cleansingflame_hermes_heal_min_damage", fallback = -8.0 },
    max_damage = { handler = "scaled_cleansingflame_hermes_heal_max_damage", fallback = -15.0 },
    max_level = 35,
    extra_spells = {
        { spell = "cleansingflame_hermes_burn" },
        { spell = "pain_split" },
        { spell = "eoc_restoration_setup", self = true },
    },
    flags = { "RESTORATION_SPELL", "RANDOM_DAMAGE", "SOMATIC", "VERBAL", "CONCENTRATE", "LOUD" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "cleansingflame_hermes_burn",
    name = ccb.content.text_without_extraction("Hermes Reborn Fire"),
    description = ccb.content.text_without_extraction("Give some frost damage for Hermes Reborn spell.  Subspell; you aren't allowed to see it except in debug mode."),
    valid_targets = { "self" },
    max_level = 35,
    flags = { "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    min_damage = 8,
    max_damage = 20,
    min_range = 1,
    max_range = 1,
    damage_type = "cold",
    min_aoe = 3,
    max_aoe = 5,
    aoe_increment = 0.06,
    spell_class = "CLEANSING_FLAME",
}

ccb.content.define_spell {
    id = "burning_trail",
    shape = "blast",
    spell_class = "CLEANSING_FLAME",
    magic_type = "magiclysm_evocation_magic",
    name = "Burning Trail",
    description = "Speak a short phrase and transform your footsteps into burning pits of flame, leaving a trail of fire behind you.  Each step will consume mana, but you will be immune to fire while the spell is in effect.",
    flags = {
        "EVOCATION_SPELL",
        "CONCENTRATE",
        "VERBAL",
        "NO_HANDS",
        "MUST_HAVE_CLASS_TO_LEARN",
        "NO_FAIL",
    },
    valid_targets = { "self" },
    base_energy_cost = 25,
    difficulty = 8,
    max_level = 1,
    base_casting_time = { handler = "w16b_sp_stat_magiclysm_5d46ffb57ea5", fallback = 0 },
    impact_handler = "w16b_sp_imp_magiclysm_60fd72496d14",
    extra_spells = {
        { spell = "eoc_evocation_setup", self = true },
    },
}
