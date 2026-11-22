local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_smoke_immunity_spell",
    name = ccb.content.text_without_extraction("In a Cloud of Smoke Immunity"),
    description = ccb.content.text_without_extraction("Makes the Salamander immune to smoke so they won't inhale tons of smoke when teleporting.  It's a bug if you have it directly."),
    valid_targets = { "self" },
    skill = "deduction",
    effect = "attack",
    effect_data = "effect_salamander_smoke_immunity",
    shape = "blast",
    min_duration = 300,
    max_duration = 300,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "salamander_smoke_teleport_spell_emit",
    name = ccb.content.text_without_extraction("In a Cloud of Smoke Emit"),
    description = ccb.content.text_without_extraction("Releases the smoke from casting In a Puff of Smoke.  It's a bug if you have it directly."),
    skill = "deduction",
    valid_targets = { "none" },
    effect = "emit",
    effect_data = "emit_smoke_stream",
    shape = "blast",
}

ccb.content.define_spell {
    id = "salamander_flaming_whip_spell",
    skill = "deduction",
    shape = "blast",
    effect = "spawn_item",
    effect_data = "salamander_flaming_summon_whip",
    spell_class = "SALAMANDER",
    magic_type = "xedra_salamader_magick",
    name = "A Hundred Tongues of Flame",
    description = "Summon a flaming whip to scourge your enemies.",
    teachable = false,
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "RANDOM_DURATION" },
    valid_targets = { "none" },
    min_damage = 1,
    max_damage = 1,
    min_duration = { handler = "wave14a_xedra_evolved_stat_117", fallback = 0 },
    max_duration = { handler = "wave14a_xedra_evolved_stat_118", fallback = 0 },
    base_energy_cost = { handler = "wave14a_xedra_evolved_stat_119", fallback = 0 },
    difficulty = 5,
    max_level = 15,
    base_casting_time = { handler = "wave14a_xedra_evolved_stat_120", fallback = 0 },
    learned_spells = {
        { spell = "salamander_fire_dot_spell", level = 6 },
    },
}

ccb.content.define_spell {
    id = "salamander_smoke_teleport_spell",
    skill = "deduction",
    shape = "blast",
    effect = "short_range_teleport",
    spell_class = "SALAMANDER",
    magic_type = "xedra_salamader_magick",
    name = "In a Cloud of Smoke",
    description = "Like fire leaping over a firebreak, you can vanish and reappear somewhere nearby, leaving a thick cloud of smoke in your former location.",
    teachable = false,
    flags = { "SILENT", "VERBAL", "SOMATIC", "NO_LEGS", "RANDOM_AOE", "EXTRA_EFFECTS_FIRST" },
    valid_targets = { "none" },
    min_range = 10,
    max_range = 10,
    min_aoe = 1,
    max_aoe = 5,
    base_energy_cost = { handler = "wave14a_xedra_evolved_stat_121", fallback = 0 },
    difficulty = 3,
    max_level = 15,
    base_casting_time = 50,
    extra_spells = {
        { spell = "salamander_smoke_immunity_spell", self = true },
        { spell = "salamander_smoke_teleport_spell_emit", self = true },
    },
}
