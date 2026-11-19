local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_alien_weed_1",
    name = ccb.content.text("alien plant"),
    description = ccb.content.text("An alien plant, a knee-high tightly-coiled bundle of reddish-yellow stalks with jagged leaves extending every which way.  It looks very difficult to walk through."),
    symbol = ",",
    move_cost_mod = 3,
    color = { "red", "red", "red", "light_red" },
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC", "ROUGH", "PAINFUL" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = {
            { item = "withered", chance = 50, count = { 1, 2 } },
            { item = "alien_leaves", count = { 5, 9 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_alien_weed_2",
    name = ccb.content.text("alien plant"),
    description = ccb.content.text("An alien plant, a collection of delicate bluish-white strands with small white globes along their length.  They seem to float almost like seaweed, despite being a terrestrial plant."),
    symbol = ",",
    move_cost_mod = 0,
    color = { "white", "blue", "light_blue", "white" },
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = {
            { item = "withered", chance = 50, count = { 1, 2 } },
            { item = "alien_leaves", count = { 1, 2 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_alien_weed_3",
    name = ccb.content.text("alien plant"),
    description = ccb.content.text("An alien plant, a single, cylindrical dark-red trunk with a small cluster of leaves on top.  It makes a hollow sound when struck."),
    symbol = ",",
    move_cost_mod = 1,
    color = { "red", "red", "light_red", "dark_gray" },
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = {
            { item = "withered", chance = 50, count = { 1, 2 } },
            { item = "alien_leaves", count = { 2, 4 } },
        },
    },
}
