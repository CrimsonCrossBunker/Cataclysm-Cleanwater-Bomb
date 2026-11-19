local ccb = require("ccb")

ccb.content.define_item {
    id = "alien_tree_1_fruit",
    name = ccb.content.text("alien fruit"),
    description = ccb.content.text("A bluish-green ovoid globule, firm to the touch but looking more like gelatin than something you plucked from a tree.  It has a strong acrid odor."),
    mass = "220 g",
    volume = "232 ml",
    color = "magenta",
    symbol = "%",
    comestible = {
        shelf_life = "6 hours",
        kind = "FOOD",
        quench = 5,
        calories = 20,
        fun = -6,
        vitamins = { { id = "mutant_toxin", amount = 800 } },
    },
}

ccb.content.define_item {
    id = "egg_cockatrice",
    name = ccb.content.text("cockatrice egg"),
    copy_from = "egg_chicken",
    comestible = {},
    inheritance = { add = { rot_spawn = { group = "GROUP_EGG_COCKATRICE" } } },
}
