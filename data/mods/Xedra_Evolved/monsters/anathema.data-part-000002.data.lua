local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "VAMPIRE_ANATHEMA_STARTS_BATTLE",
    name = ccb.content.text_without_extraction("Anathema Start Battle"),
    description = ccb.content.text_without_extraction("This accelerates and empowers the Anathema after they get injured, as they decide to mess around a little less."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "NO_FAIL", "NO_LEGS", "NO_HANDS" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_anathema_battle_started",
    spell_class = "NONE",
    energy_source = "NONE",
    max_level = 1,
    min_duration = 3000000,
    max_duration = 3000000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "VAMPIRE_ANATHEMA_HEAL",
    name = ccb.content.text_without_extraction("Cure Anathema Wounds"),
    description = ccb.content.text_without_extraction("Heals a little bit of damage on the Anathema.  For Anathema use only."),
    valid_targets = { "self" },
    min_damage = -25,
    max_damage = -250,
    effect = "attack",
    shape = "blast",
    base_casting_time = 0,
    flags = { "NO_EXPLOSION_SFX", "SILENT", "NO_FAIL", "NO_LEGS", "NO_HANDS" },
    max_level = 10,
    damage_increment = -25,
    spell_class = "NONE",
    energy_source = "NONE",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "VAMPIRE_ANATHEMA_FINAL_FORM",
    name = ccb.content.text_without_extraction("Anathema Final Form"),
    description = ccb.content.text_without_extraction("This accelerates and empowers the Anathema as per blood haste and shadow form, as they decide to stop messing around.  It also heals them fully, so they can benefit from that form longer.  At this point the Anathema has almost ran out of blood, preventing the use of more powers."),
    flags = { "NO_EXPLOSION_SFX", "SILENT", "NO_FAIL", "NO_LEGS", "NO_HANDS" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_anathema_final_form",
    spell_class = "NONE",
    energy_source = "NONE",
    max_level = 1,
    min_duration = 3000000,
    max_duration = 3000000,
    extra_spells = { { spell = "VAMPIRE_ANATHEMA_HEAL", self = true, min_level = 10 } },
}
