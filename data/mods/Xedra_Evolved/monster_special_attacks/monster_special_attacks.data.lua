local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_ratking",
    name = ccb.content.text_without_extraction("Rat King Death"),
    description = ccb.content.text_without_extraction("Rat king dies."),
    valid_targets = { "hostile", "ally" },
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    effect = "remove_effect",
    effect_data = "rat",
    min_range = 48,
    max_range = 48,
    extra_spells = { { spell = "ratking_summon_rats", self = true } },
}

ccb.content.define_spell {
    id = "vampire_suck",
    shape = "blast",
    damage_type = "stab",
    name = ccb.content.text_without_extraction("Sucking bite"),
    description = ccb.content.text_without_extraction("Sucks blood from one foe."),
    flags = { "NO_HANDS", "NO_LEGS" },
    valid_targets = { "hostile" },
    min_damage = 15,
    damage_increment = 1.0,
    max_damage = 25,
    min_range = 1,
    max_range = 1,
    max_level = 10,
    impact_handler = "w16b_sp_imp_xedra_evolved_f971d7739905",
    extra_spells = {
        { spell = "xe_light_healing", self = true },
    },
}
