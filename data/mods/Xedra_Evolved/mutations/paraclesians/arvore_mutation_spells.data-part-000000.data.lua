local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xedra_arvore_magick",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_FEY_MAGIC", "NO_SPELLCASTING" },
    cannot_cast_message = ccb.content.text("You can't draw on the power of nature!"),
    failure_cost_fraction = 0.25,
    max_book_level = 0,
    casting_xp_formula = "xe_fey_elemental_magick_arvore_exp_per_cast",
    failure_chance_formula = "xe_fey_elemental_magick_arvore_failure_chance",
}
