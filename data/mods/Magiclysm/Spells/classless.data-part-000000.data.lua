local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "crystallize_mana_1",
    name = ccb.content.text_without_extraction("Crystallize Mana (1)"),
    description = ccb.content.text_without_extraction("Mana Crystal Spawner.  If you can see this you probably debugged it in."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "CHANNELING_SPELL", "PERMANENT", "NO_LEGS", "CONCENTRATE" },
    difficulty = 1,
    min_damage = 1,
    max_damage = 1,
    duration_increment = 1,
    effect = "spawn_item",
    effect_data = "crystallized_mana",
    shape = "blast",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 0,
    final_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "crystallize_mana_crystal_5",
    name = ccb.content.text_without_extraction("Crystallize Mana (5)"),
    description = ccb.content.text_without_extraction("Mana Crystal Spawner.  If you can see this you probably debugged it in."),
    valid_targets = { "self" },
    spell_class = "NONE",
    flags = { "CHANNELING_SPELL", "PERMANENT", "NO_LEGS", "CONCENTRATE" },
    effect = "spawn_item",
    effect_data = "crystallized_mana",
    difficulty = 1,
    min_damage = 5,
    max_damage = 5,
    duration_increment = 1,
    shape = "blast",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 0,
    final_casting_time = 0,
}

-- NO_I18N
-- NO_I18N
-- actual sleepiness gained is 1/100th duration, at 6000 you get 60 fatigue.
ccb.content.define_spell {
    id = "mana_fatigue",
    name = ccb.content.text_without_extraction("Mana Fatigue"),
    description = ccb.content.text_without_extraction("Secondary effect of Crystallize Mana."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "mana_fatigue",
    shape = "blast",
    max_level = 1,
    min_duration = 6000,
    max_duration = 6000,
}

ccb.content.define_spell {
    id = "dark_sight",
    name = ccb.content.text("Dark Sight"),
    description = ccb.content.text("Gives you the power to see in the dark."),
    message = ccb.content.text("Your eyes glow green for a moment.  Now your sight can pierce the darkest shadows."),
    flags = { "ENHANCEMENT_SPELL", "VERBAL", "NO_LEGS", "CONCENTRATE" },
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "dark_sight",
    shape = "blast",
    base_casting_time = 100,
    base_energy_cost = 175,
    magic_type = "magiclysm_enhancement_magic",
    difficulty = 2,
    max_level = 20,
    min_duration = 100000,
    max_duration = 1000000,
    duration_increment = 45000,
    extra_spells = { { spell = "eoc_enhancement_setup", self = true } },
}
