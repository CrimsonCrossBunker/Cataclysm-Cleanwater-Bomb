local ccb = require("ccb")

ccb.content.define_spell {
    id = "xedra_dreamsmith_time_trap_freeze",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "effect_xedra_time_freeze",
    name = ccb.content.text_without_extraction("Time Freeze"),
    description = ccb.content.text_without_extraction("Freezes the target in time.  Having this spell is a bug."),
    teachable = false,
    flags = { "NO_FAIL", "SILENT", "NO_EXPLOSION_SFX", "NO_PROJECTILE" },
    valid_targets = { "hostile", "ground", "ally" },
    energy_source = "NONE",
    min_range = 1,
    max_range = 1,
    min_duration = 1440000,
    max_duration = 1440000,
    base_energy_cost = 0,
    difficulty = 0,
    max_level = 1,
    base_casting_time = 0,
    extra_spells = {
        {
            spell = "xedra_dreamsmith_time_trap_freeze_spawn_trap",
        },
    },
}
