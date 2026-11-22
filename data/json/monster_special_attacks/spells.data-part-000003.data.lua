local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shifting_mass_attack",
    name = ccb.content.text_without_extraction("Shifting Mass Attack"),
    description = ccb.content.text_without_extraction("Drains some of your essence."),
    copy_from = "base_portal",
    min_damage = -25,
    max_damage = -50,
    damage_increment = -10.0,
    effect_data = "EOC_shifting_mass_attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "portal_hurt_self",
    name = ccb.content.text_without_extraction("Hurt Self"),
    description = ccb.content.text_without_extraction("Touching/perceiving you is bad for the other side as well."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 5,
    max_damage = 5,
    damage_type = "pure",
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "portal_severely_hurt_self",
    name = ccb.content.text_without_extraction("Hurt Self"),
    description = ccb.content.text_without_extraction("Touching/perceiving you is bad for the other side as well."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_damage = 30,
    max_damage = 30,
    damage_type = "pure",
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
}

ccb.content.define_spell {
    id = "base_portal",
    shape = "blast",
    name = ccb.content.text_without_extraction("Base characteristics of portal spells"),
    description = ccb.content.text_without_extraction("Base portal stats."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 1,
    max_range = 1,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_ba42177bae6f",
    extra_spells = {
        { spell = "portal_hurt_self", self = true },
    },
}
