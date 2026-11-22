local ccb = require("ccb")

ccb.content.define_spell {
    id = "dream_mana_gain",
    skill = "deduction",
    shape = "blast",
    effect = "recover_energy",
    effect_data = "MANA",
    name = ccb.content.text_without_extraction("Mana gain from dreams"),
    description = "Your dreaming experiences refill your mana.  Consumed in the mysterious activity of expansion and contraction.",
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_1", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_2", fallback = 0 },
    base_energy_cost = 0,
    max_level = { handler = "wave14a_xedra_evolved_stat_3", fallback = 0 },
    base_casting_time = 0,
}

ccb.content.define_spell {
    id = "nightmare_mana_gain",
    skill = "deduction",
    shape = "blast",
    effect = "recover_energy",
    effect_data = "MANA",
    name = ccb.content.text_without_extraction("Mana gain from nightmares"),
    description = "Your dreaming experiences refill your mana.  Like overused mirrors unsilvering.",
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_4", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_5", fallback = 0 },
    base_energy_cost = 0,
    max_level = { handler = "wave14a_xedra_evolved_stat_6", fallback = 0 },
    base_casting_time = 0,
}
