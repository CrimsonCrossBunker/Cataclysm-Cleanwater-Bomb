local ccb = require("ccb")

ccb.content.define_spell {
    id = "sacrificial_marked",
    name = ccb.content.text("sacrificial marked"),
    description = ccb.content.text("Shouldn't be visible.  Tracks that you are killing someone that considers you the best person in the world."),
    valid_targets = { "hostile" },
    min_range = 50,
    max_range = 50,
    min_duration = 500,
    max_duration = 500,
    difficulty = 5,
    flags = { "SILENT", "NO_SFX", "NO_LEGS", "NO_PROJECTILE" },
    shape = "blast",
    effect = "attack",
    effect_data = "about_to_kill_best_friend",
}
