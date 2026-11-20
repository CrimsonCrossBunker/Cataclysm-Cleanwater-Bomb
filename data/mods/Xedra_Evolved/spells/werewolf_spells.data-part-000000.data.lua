local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xe_werewolf_powers",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_WEREWOLF_POWERS" },
    cannot_cast_message = ccb.content.text("You cannot draw on your lunar gifts!"),
    failure_cost_fraction = 0.75,
    max_book_level = 0,
    failure_chance_formula = "werewolf_power_failure_chance",
}
