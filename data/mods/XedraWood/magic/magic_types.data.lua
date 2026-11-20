local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xedrawood_forest_magic",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_SPELLCASTING" },
    failure_cost_fraction = 0.2,
    failure_chance_formula = "xedrawood_spell_failure_chance_forest",
    cannot_cast_message = ccb.content.text("You cannot draw on the power of the forest!"),
}
