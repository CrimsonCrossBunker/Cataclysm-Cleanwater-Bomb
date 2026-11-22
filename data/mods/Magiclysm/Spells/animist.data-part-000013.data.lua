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

ccb.content.define_spell {
    id = "animist_spirit_walking",
    components = "spell_components_spirit_walking",
    shape = "blast",
    spell_class = "ANIMIST",
    magic_type = "magiclysm_transformation_magic",
    name = "Spirit-Walking",
    description = "Transform your body to pure spirit, making you invisible and intangible.  You can move incredibly quickly while the spell is in effect and can pass by enemies unseen, but you will be unable to affect the physical world or cast spells.",
    flags = { "TRANSFORMATION_SPELL", "SOMATIC", "CONCENTRATE", "VERBAL" },
    valid_targets = { "self" },
    min_duration = 3000,
    duration_increment = 300,
    max_duration = 9000,
    base_energy_cost = 1200,
    final_energy_cost = 850,
    energy_increment = -17.5,
    difficulty = 8,
    max_level = 20,
    base_casting_time = 300,
    impact_handler = "w16b_sp_imp_magiclysm_611021790624",
    extra_spells = {
        { spell = "eoc_transformation_setup", self = true },
    },
}
