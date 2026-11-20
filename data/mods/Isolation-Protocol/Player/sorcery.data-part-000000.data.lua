local ccb = require("ccb")

-- Remember for all casting times and energy costs below that without the Blackstaff, casting time is doubled and energy cost is increased by 50%!
ccb.content.define_magic_type {
    id = "iso_eldritch_sorcery",
    energy_source = "MANA",
    failure_cost_fraction = 0.5,
    cannot_cast_flags = "NO_SPELLCASTING",
    cannot_cast_message = ccb.content.text("Your powers do not come as you call them!"),
    get_level_formula = "iso_eldritch_sorcery_formula_get_level",
    exp_for_level_formula = "iso_eldritch_sorcery_formula_exp_for_level",
    casting_xp_formula = "iso_eldritch_sorcery_formula_exp_per_cast",
    failure_chance_formula = "iso_eldritch_sorcery_failure_chance",
}
