local ccb = require("ccb")

-- Despite providing a buff, this is a Conjuration spell because the buff is provided by the summoned spirit.
ccb.content.define_spell {
    id = "animist_add_evasion_spell",
    name = ccb.content.text("Guardian Spirit"),
    description = ccb.content.text("Summon a benevolent spirit to keep watch over you and warn you of imminent attacks, allowing you to dodge some of them."),
    valid_targets = { "self" },
    spell_class = "ANIMIST",
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_animist_add_evasion",
    shape = "blast",
    magic_type = "magiclysm_conjuration_magic",
    difficulty = 4,
    max_level = 15,
    base_energy_cost = 350,
    min_duration = 30000,
    max_duration = 480000,
    duration_increment = 30000,
    base_casting_time = 250,
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
}
