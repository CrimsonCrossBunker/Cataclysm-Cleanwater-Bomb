local ccb = require("ccb")

-- Winter magic should focus on: darkness, silence, sleep, stasis, ice, snow, cold, wind, death.
-- Make sure to add each new spell to the proper research EoC in the playable_changeling_seasonal_magic_research_eocs file.
-- Seasonal magic can have direct damage spells, but they should always be relevantly themed to the season, accomplish some secondary effect (slowing, blinding, starting fires, terrain alteration, etc), have some limitation on targets, or otherwise be less efficient than 'Wizard casts fireball'
ccb.content.define_magic_type {
    id = "xe_fey_seasonal_magick_winter",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_FEY_MAGIC", "NO_SPELLCASTING" },
    cannot_cast_message = ccb.content.text("You can't use your glamours now!"),
    failure_cost_fraction = 0.75,
    max_book_level = 0,
    failure_chance_formula = "xe_fey_seasonal_magick_winter_failure_chance",
}
