local ccb = require("ccb")

ccb.content.define_spell {
    id = "nl_destruction_ray",
    name = ccb.content.text("Labyrinth Destruction Ray"),
    description = ccb.content.text("Destruction ray for turret in labyrinthine structures."),
    valid_targets = { "ground" },
    effect = "bash",
    flags = { "LOUD", "IGNORE_WALLS" },
    shape = "line",
    min_damage = 999,
    max_damage = 999,
    min_aoe = 1,
    max_aoe = 1,
    min_range = 20,
    max_range = 20,
}
