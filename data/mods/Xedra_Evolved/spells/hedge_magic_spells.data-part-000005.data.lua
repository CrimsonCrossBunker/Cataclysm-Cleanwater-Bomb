local ccb = require("ccb")

ccb.content.define_spell {
    id = "hedge_no_nightmares",
    name = ccb.content.text("To Sail on the River of Dreams"),
    description = ccb.content.text("With lavender and thyme, weave a barrier around your sleeping space to keep bad dreams away.  You must perform the charm directly before trying to sleep; moving will breach the barrier and allow the nightmares to find a way in again."),
    message = ccb.content.text("You place the herbs under your pillow and, while chanting the words of the charm, paint some thyme oil on the four corners of your sleeping space."),
    flags = { "VERBAL", "SOMATIC", "NO_FAIL" },
    magic_type = "xe_hedge_magick",
    valid_targets = { "self" },
    difficulty = 40,
    spell_class = "HEDGE_MAGIC",
    skill = "survival",
    effect = "attack",
    effect_data = "effect_hedge_no_nightmares",
    shape = "blast",
    components = "spell_components_hedge_no_nightmares",
    max_level = 1,
    base_casting_time = 60000,
    min_duration = 4320000,
    max_duration = 4320000,
}
