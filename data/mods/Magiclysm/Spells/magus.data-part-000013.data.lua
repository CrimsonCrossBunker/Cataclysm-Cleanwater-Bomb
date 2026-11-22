local ccb = require("ccb")

ccb.content.define_spell {
    id = "magus_push_nearby_enemies_back",
    shape = "blast",
    spell_class = "MAGUS",
    magic_type = "magiclysm_evocation_magic",
    name = "Repulsion Wave",
    description = "Unleash a wave of force, hurling all nearby targets away from you.  Heavier targets are harder to affect.",
    flags = { "EVOCATION_SPELL", "VERBAL", "SOMATIC" },
    valid_targets = { "ally", "hostile" },
    min_aoe = 1,
    aoe_increment = 0.2,
    max_aoe = 3,
    base_energy_cost = 350,
    difficulty = 5,
    max_level = 20,
    base_casting_time = 75,
    impact_handler = "w16b_sp_imp_magiclysm_df1ddfed09ea",
    extra_spells = {
        { spell = "eoc_evocation_setup", self = true },
    },
}
