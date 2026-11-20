local ccb = require("ccb")

-- Bloodthorne druid spells should deal with blood, thorns, the wilderness, and fighting vampires.  Their spells do not always have to affect vampires in some way, but they should generally be oriented toward combat against them--they can use Arvore magic as more generalist nature magic.
ccb.content.define_magic_type {
    id = "xedra_bloodthorne_sorcery",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_THORNWITCHERY", "NO_SPELLCASTING" },
    cannot_cast_message = ccb.content.text("Your thornwitchery will not come to your call!"),
    failure_cost_fraction = 0.75,
    max_book_level = 0,
    failure_chance_formula = "xe_bloodthorne_sorcery_failure_chance",
}
