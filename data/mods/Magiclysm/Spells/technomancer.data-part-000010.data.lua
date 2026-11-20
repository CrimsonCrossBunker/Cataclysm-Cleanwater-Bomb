local ccb = require("ccb")

-- The damage being unaffected by spell level is intentional
ccb.content.define_spell {
    id = "technomancer_knifeshot_superior",
    name = ccb.content.text("Hypervelocity Knifeshot"),
    description = ccb.content.text("This spell goes even further beyond, launching a knife so fast it can pierce through targets."),
    valid_targets = { "hostile", "ally" },
    flags = { "EVOCATION_SPELL", "RANDOM_DAMAGE", "CONCENTRATE", "LOUD", "SOMATIC", "NO_HANDS", "NO_FAIL" },
    extra_spells = { { spell = "eoc_evocation_setup", self = true } },
    components = "spell_components_knifeshot",
    effect = "attack",
    shape = "line",
    spell_class = "TECHNOMANCER",
    magic_type = "magiclysm_evocation_magic",
    energy_source = "BIONIC",
    difficulty = 7,
    max_level = 1,
    base_casting_time = 500,
    base_energy_cost = 125,
    min_damage = 70,
    max_damage = 100,
    damage_type = "bullet",
    min_range = 7,
    max_range = 7,
    min_pierce = 15,
    max_pierce = 15,
}
