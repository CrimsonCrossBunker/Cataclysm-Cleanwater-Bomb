local ccb = require("ccb")

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
