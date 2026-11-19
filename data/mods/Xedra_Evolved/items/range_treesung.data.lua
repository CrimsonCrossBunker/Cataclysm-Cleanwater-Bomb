local ccb = require("ccb")

ccb.content.define_item {
    id = "treesung_bow",
    copy_from = "shortbow",
    looks_like = "shortbow",
    name = ccb.content.text("treesung bow"),
    description = ccb.content.text("A wooden shortbow with a thin vine for a string, all formed from a single piece of wood, with twists and curves like it grew in place rather than being made."),
    color = "green",
    inheritance = { add = { flags = { "WOODEN_WEAPON", "NO_REPAIR" } } },
    gun = { range = 14 },
}

ccb.content.define_item {
    id = "treesung_greatbow",
    copy_from = "woodgreatbow",
    looks_like = "woodgreatbow",
    name = ccb.content.text("treesung greatbow"),
    description = ccb.content.text("A truly enormous wooden bow with a thin vine for a string, all formed from a single piece of wood, with twists and curves like it grew in place rather than being made."),
    color = "green",
    inheritance = { add = { flags = { "WOODEN_WEAPON", "NO_REPAIR" } } },
    gun = { range = 26 },
}

ccb.content.define_item {
    id = "arrow_treesung",
    copy_from = "arrow_fire_hardened_fletched",
    name = ccb.content.text("treesung arrow"),
    description = ccb.content.text("An arrow all formed from a single piece of wood, with twists and curves like it grew in place rather than being made.  It even has leaves for fletching."),
    color = "green",
    ammunition = {
        damage = { type = "stab", penetration = 4, constant_damage_multiplier = 1.25 },
        recovery_chance = 85,
    },
}
