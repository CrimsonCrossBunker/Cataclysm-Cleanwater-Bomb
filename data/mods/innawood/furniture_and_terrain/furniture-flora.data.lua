local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_wildcotton",
    name = ccb.content.text("wild cotton"),
    description = ccb.content.text("A cotton plant, growing wild and feral."),
    symbol = "i",
    color = "white",
    looks_like = "f_mustard",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "wildcotton_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_wildsbeet",
    name = ccb.content.text("wild sugar beet"),
    description = ccb.content.text("Sugar beet plant, growing wild without human touch."),
    symbol = "i",
    color = "magenta",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "wildsbeet_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_wildweed",
    name = ccb.content.text("wild cannabis"),
    description = ccb.content.text("A riotous snarl of cannabis, all stalks and five-pointed leaves."),
    symbol = "i",
    color = "green",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "wildweed_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_wildpumpkin",
    name = ccb.content.text("wild pumpkins"),
    description = ccb.content.text("A tangled mess of hairy vines and pale yellow trumpet flowers.  Is that a pumpkin hidden in this mess?"),
    symbol = "i",
    color = "yellow",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "wildpumpkin_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_wildcorn",
    name = ccb.content.text("wild corn"),
    description = ccb.content.text("Tall green stalks with what looks like hair growing out of nodes along its length.  You're pretty sure this is corn."),
    symbol = "i",
    looks_like = "f_mustard",
    color = "cyan",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "wildcorn_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_wildbeans",
    name = ccb.content.text("wild beans"),
    description = ccb.content.text("A mess of vines strangling a dead bush.  There are pods and tiny white flowers growing along them."),
    symbol = "i",
    looks_like = "f_chamomile",
    color = "brown",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "wildbeans_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}
