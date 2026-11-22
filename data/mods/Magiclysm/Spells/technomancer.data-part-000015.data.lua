local ccb = require("ccb")

ccb.content.define_spell {
    id = "technomancer_create_ups_connection",
    components = "spell_components_create_ups_connection",
    shape = "blast",
    spell_class = "TECHNOMANCER",
    magic_type = "magiclysm_enhancement_magic",
    name = "Power Linkage",
    description = "Enchant an item so that it is capable of drawing power wirelessly through the air from a compatible power source.",
    flags = { "ENHANCEMENT_SPELL", "CONCENTRATE", "VERBAL", "NO_HANDS" },
    valid_targets = { "self" },
    base_energy_cost = 600,
    difficulty = 6,
    max_level = 15,
    base_casting_time = 720000,
    impact_handler = "w16b_sp_imp_magiclysm_2ee93df0c0c7",
    extra_spells = {
        { spell = "eoc_enhancement_setup", self = true },
    },
}
