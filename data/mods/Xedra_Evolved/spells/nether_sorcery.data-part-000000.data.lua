local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xe_nether_sorcery",
    energy_source = "STAMINA",
    failure_cost_fraction = 0.5,
    max_book_level = 5,
    cannot_cast_flags = "NO_SPELLCASTING",
    cannot_cast_message = ccb.content.text("Your powers do not come as you call them!"),
    failure_chance_formula = "xe_nether_sorcery_failure_chance",
}
