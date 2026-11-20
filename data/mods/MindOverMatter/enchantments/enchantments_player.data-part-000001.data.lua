local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokin_zap_attacked",
    name = ccb.content.text_without_extraction("Electrokinetic aura thorns"),
    description = ccb.content.text_without_extraction("Do electrical damage to a monster that attacked you.  If you have this directly its a bug."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "attack",
    damage_type = "electric",
    min_damage = { handler = "scale_electrokin_zap_attacked_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_electrokin_zap_attacked_max_damage", fallback = 0.0 },
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electrokin_zap_attack",
    name = ccb.content.text_without_extraction("Electrokinetic melee attacks"),
    description = ccb.content.text_without_extraction("Do electrical damage to a monster you attack.  If you have this directly its a bug."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE", "RANDOM_AOE" },
    shape = "blast",
    effect = "attack",
    damage_type = "electric",
    min_damage = { handler = "scale_electrokin_zap_attack_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_electrokin_zap_attack_max_damage", fallback = 0.0 },
    min_range = 1,
    max_range = 1,
    min_aoe = 0,
    max_aoe = 1,
    field = "fd_electricity",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 4,
    field_intensity_variance = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "photokin_blinding_glare_attack",
    name = ccb.content.text_without_extraction("Photokinetic Blinding Radiance burst"),
    description = ccb.content.text_without_extraction("Blind nearby targets."),
    valid_targets = { "hostile", "ally" },
    flags = { "SILENT", "RANDOM_DURATION" },
    max_level = { handler = "scale_photokin_blinding_glare_attack_max_level", fallback = 0 },
    shape = "blast",
    effect = "attack",
    effect_data = "blind",
    min_aoe = { handler = "scale_photokin_blinding_glare_attack_min_aoe", fallback = 0.0 },
    max_aoe = 40,
    min_range = { handler = "scale_photokin_blinding_glare_attack_min_aoe", fallback = 0.0 },
    min_duration = 500,
    max_duration = 2000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyro_aura_attack",
    name = ccb.content.text_without_extraction("Pyrokinetic aura stabbing"),
    description = ccb.content.text_without_extraction("Do fire damage to a monster that you attack."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE", "IGNITE_FLAMMABLE" },
    shape = "blast",
    effect = "attack",
    damage_type = "heat",
    min_damage = { handler = "scale_pyro_aura_attack_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_pyro_aura_attack_max_damage", fallback = 0.0 },
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyro_aura_attacked",
    name = ccb.content.text_without_extraction("Pyrokinetic aura thorns"),
    description = ccb.content.text_without_extraction("Do fire damage to a monster that attacked you."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE", "IGNITE_FLAMMABLE" },
    shape = "blast",
    effect = "attack",
    damage_type = "heat",
    min_damage = { handler = "scale_pyro_aura_attack_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_pyro_aura_attacked_max_damage", fallback = 0.0 },
    min_range = 1,
    max_range = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electro_potion_attacked",
    name = ccb.content.text_without_extraction("Electrokinetic aura thorns"),
    description = ccb.content.text_without_extraction("Do electrical damage to a monster that attacked you and daze them."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "dazed",
    damage_type = "electric",
    min_damage = { handler = "scale_electro_potion_attacked_min_damage", fallback = 0.0 },
    max_damage = { handler = "scale_electro_potion_attacked_max_damage", fallback = 0.0 },
    min_range = 1,
    max_range = 1,
    min_duration = 100,
    max_duration = 400,
}
