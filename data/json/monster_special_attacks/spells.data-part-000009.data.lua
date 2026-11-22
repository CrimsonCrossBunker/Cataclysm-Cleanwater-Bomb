local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hallu_touch_suicide",
    name = ccb.content.text_without_extraction("Hallucination Touch Dissipation"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile", "ally", "self" },
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    damage_type = "pure",
    min_damage = 100000000,
    max_damage = 100000000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hallucinator_touch",
    name = ccb.content.text_without_extraction("Give The Hallucination Effect"),
    description = ccb.content.text_without_extraction("Spell that gives the player the effect, that will cause short term hallucination attacks.  You can see it only in debug menu."),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "hallucination_attacks",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 0,
    max_damage = 0,
    min_range = 1,
    max_range = 1,
    min_duration = 25920000,
    max_duration = 25920000,
    extra_spells = { { spell = "hallu_touch_suicide", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flatlander_attack",
    name = ccb.content.text_without_extraction("flatlander attack"),
    description = ccb.content.text_without_extraction("Dazes the player"),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "stunned",
    min_range = 4,
    max_range = 4,
    shape = "blast",
    message = "",
    min_duration = 100,
    max_duration = 400,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    extra_spells = { { spell = "flatlander_attack_nausea" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flatlander_attack_nausea",
    name = ccb.content.text_without_extraction("flatlander attack nausea"),
    description = ccb.content.text_without_extraction("Makes enemy nauseous"),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    message = "",
    min_duration = 300,
    max_duration = 1000,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    effect_data = "nausea",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sloth_attack",
    name = ccb.content.text_without_extraction("Sloth Attack"),
    description = ccb.content.text_without_extraction("Slows you."),
    copy_from = "base_portal",
    effect_data = "EOC_sloth_attack",
}

ccb.content.define_spell {
    id = "mon_XEDRA_officer_banish",
    shape = "blast",
    name = ccb.content.text_without_extraction("Officer banish"),
    description = ccb.content.text_without_extraction("Stops the haunting."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self", "ground" },
    min_range = 15,
    max_range = 15,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_524665f3baae",
}

ccb.content.define_spell {
    id = "mon_tainted_shadow_revive",
    shape = "blast",
    name = ccb.content.text_without_extraction("Tainted Shadow Revive"),
    description = ccb.content.text_without_extraction("Revives the tainted shadow."),
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "ground" },
    min_range = 15,
    max_range = 15,
    max_level = 1,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_dda_321a1ae0df67",
}
