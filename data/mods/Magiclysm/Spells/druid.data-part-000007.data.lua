local ccb = require("ccb")

ccb.content.define_spell {
    id = "druid_healing_herb",
    name = ccb.content.text("Floral Healing"),
    description = ccb.content.text("Use some magic herbs to heal yourself."),
    components = "spell_components_healing_herb",
    valid_targets = { "self" },
    effect = "attack",
    shape = "blast",
    flags = { "RESTORATION_SPELL", "CONCENTRATE", "RANDOM_DAMAGE", "SOMATIC", "VERBAL", "NO_LEGS" },
    magic_type = "magiclysm_restoration_magic",
    spell_class = "DRUID",
    min_damage = { handler = "scaled_druid_healing_herb_min_damage", fallback = -2.0 },
    max_damage = { handler = "scaled_druid_healing_herb_max_damage", fallback = -5.0 },
    difficulty = 5,
    base_casting_time = 800,
    base_energy_cost = 400,
    final_energy_cost = 150,
    energy_increment = -16.7,
    extra_spells = { { spell = "eoc_restoration_setup", self = true } },
    max_level = 15,
}
