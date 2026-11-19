local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_mana",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Mana"),
    description = ccb.content.text_without_extraction("Eater's spell to drain mana.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    max_level = 1,
    min_damage = -150,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_stamina",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Stamina"),
    description = ccb.content.text_without_extraction("Eater's spell to drain stamina.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "recover_energy",
    effect_data = "STAMINA",
    extra_spells = { { spell = "eater_drain_sleepiness", self = false, max_level = 3 } },
    shape = "blast",
    max_level = 1,
    min_damage = -200,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_sleepiness",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Sleepiness"),
    description = ccb.content.text_without_extraction("Eater's spell to drain sleepiness.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "recover_energy",
    effect_data = "SLEEPINESS",
    shape = "blast",
    max_level = 1,
    min_damage = -2,
    min_range = 30,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "eater_drain_health",
    name = ccb.content.text_without_extraction("[Ψ]Eater Drain Stamina"),
    description = ccb.content.text_without_extraction("Eater's spell to drain health.  It's a bug if you have it."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    max_level = 1,
    min_damage = 1,
    max_damage = 2,
    min_range = 30,
}
