local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xe_hedge_magick",
    energy_source = "MANA",
    cannot_cast_flags = { "GRAB", "NO_HEDGE_MAGICK", "NO_SPELLCASTING" },
    cannot_cast_message = ccb.content.text("You can't perform any of your rituals now!"),
    failure_cost_fraction = 0.0,
    max_book_level = 0,
}
