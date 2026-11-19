local ccb = require("ccb")

-- CCB: 恢复 PR #87197 (RenechCDDA) 移除的 FLAMMABLE_ASH flag，真菌地形重新可燃
ccb.content.define_terrain {
    id = "t_marloss",
    name = ccb.content.text("Marloss bush"),
    description = ccb.content.text("This alien plant superficially resembles a blueberry bush, and hangs with large, juicy pink pomes that emit a heady, fruity aroma."),
    symbol = "#",
    color = "pink",
    move_cost = 8,
    coverage = 40,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "FUNGUS", "SHRUB", "SHORT", "GRAZER_INEDIBLE" },
    builtin_examine = "shrub_marloss",
    bash = {
        minimum_strength = 4,
        maximum_strength = 60,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

-- muffled because fungus
ccb.content.define_terrain {
    id = "t_fungus",
    name = ccb.content.text("fungal bed"),
    description = ccb.content.text("Fungus grows thick here, obscuring the ground beneath it."),
    symbol = ".",
    color = "light_gray",
    move_cost = 3,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "FUNGUS", "NOCOLLIDE" },
    bash = {
        sound = ccb.content.text("smash"),
        terrain = "t_null",
        minimum_strength = 20,
        maximum_strength = 400,
        minimum_strength_supported = 50,
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

-- roofed
ccb.content.define_terrain {
    id = "t_fungus_floor_in",
    name = ccb.content.text("fungal floor"),
    description = ccb.content.text("Grayish mold coats both the floor and the roof here, silent and still.  Stray spores waft through the air."),
    symbol = ".",
    color = "light_gray",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "FUNGUS" },
    bash = {
        sound = ccb.content.text("smash"),
        terrain = "t_null",
        minimum_strength = 20,
        maximum_strength = 400,
        minimum_strength_supported = 50,
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

-- supports
ccb.content.define_terrain {
    id = "t_fungus_floor_sup",
    name = ccb.content.text("fungal floor"),
    description = ccb.content.text("Grayish mold coats the floor here, silent and still."),
    symbol = ".",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "SUPPORTS_ROOF", "FLAT", "FUNGUS" },
    bash = {
        sound = ccb.content.text("smash"),
        terrain = "t_null",
        minimum_strength = 20,
        maximum_strength = 400,
        minimum_strength_supported = 50,
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

-- outside
ccb.content.define_terrain {
    id = "t_fungus_floor_out",
    name = ccb.content.text("fungal floor"),
    description = ccb.content.text("Grayish mold coats the ground here, silent and still."),
    symbol = ".",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "FLAT", "FUNGUS" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 20,
        maximum_strength = 400,
        minimum_strength_supported = 50,
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_fungus_wall",
    name = ccb.content.text("fungal wall"),
    description = ccb.content.text("Several thick, large tendrils of fungus perforate the wall here, piercing straight through it from the outside.  Despite the apparent damage, the wall is still structurally sound."),
    symbol = "O",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "FUNGUS", "WALL", "REDUCE_SCENT", "MINEABLE" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_fungus_wall_transformed",
    name = ccb.content.text("fungal wall"),
    description = ccb.content.text("The fungus here has grown thickly and tightly enough to form a solid wall.  It feels very stiff to the touch, and seems to be very strong."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "FUNGUS",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "MINEABLE",
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_fungus_mound",
    name = ccb.content.text("fungal mound"),
    description = ccb.content.text("A mound of fungal matter, intertwined in itself."),
    symbol = "#",
    color = "light_gray",
    move_cost = 4,
    flags = { "TRANSPARENT", "THIN_OBSTACLE", "FLAMMABLE_ASH", "FUNGUS", "MOUNTABLE" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 70,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_shrub_fungal",
    name = ccb.content.text("fungal shrub"),
    description = ccb.content.text("This shrub has been completely absorbed by the mushrooms.  Its branches droop and have lost much of their structure, and its leaves have vanished, replaced by fleshy gray sacks that visibly expand and contract."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 8,
    coverage = 40,
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "FLAMMABLE_ASH",
        "THIN_OBSTACLE",
        "PLACE_ITEM",
        "SHRUB",
        "FUNGUS",
        "SHORT",
        "GRAZER_INEDIBLE",
    },
    bash = {
        minimum_strength = 4,
        maximum_strength = 60,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
        hit_field = { "fd_spores", 1 },
        destroyed_field = { "fd_fungal_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_fungal",
    name = ccb.content.text("fungal tree"),
    description = ccb.content.text("Once tall and majestic, this tree is now a slave to the fungus like the landscape around it.  Its bark is penetrated by and covered with fungal tendrils, and the canopy has rotted away, leaving only the branches, stretching forlornly to the sky as if to escape the infection overrunning it."),
    symbol = "7",
    color = "dark_gray",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "FUNGUS", "TREE", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
    },
}

ccb.content.define_terrain {
    id = "t_tree_fungal_young",
    name = ccb.content.text("young fungal tree"),
    description = ccb.content.text("A small sapling poking through the ground, infested by fungal mold."),
    symbol = "1",
    color = "dark_gray",
    move_cost = 4,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "FUNGUS", "YOUNG", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 50,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
    },
}

ccb.content.define_terrain {
    id = "t_marloss_tree",
    name = ccb.content.text("Marloss tree"),
    description = ccb.content.text("This tree stands as a stark outlier to the landscape around it.  Despite its infestation, its leaves wave proudly in the wind, colored pinkish-white.  Its branches are heavy with pink fruit that looks both mutated and delicious."),
    symbol = "7",
    color = "pink",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "FUNGUS", "TREE", "REDUCE_SCENT" },
    builtin_examine = "tree_marloss",
    bash = {
        minimum_strength = 40,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_fungus",
    },
}
