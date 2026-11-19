local ccb = require("ccb")

-- ["possibly in the future add that smashing this drops shells and tube worm flesh? maybe even an ability to cut it down for food"]
ccb.content.define_terrain {
    id = "t_tree_worm",
    name = ccb.content.text("leviathan annelids"),
    description = ccb.content.text("Several massive protrusions emerge from the ground, coiled together into a tower.  At the top, blue and purple tentacles sway in the wind."),
    symbol = "I",
    color = "magenta",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_deaddirt",
    },
}

ccb.content.define_terrain {
    id = "t_tree_lichen",
    name = ccb.content.text("lichen tree"),
    description = ccb.content.text("A massive corrugated body sprouts from the lichen here, branching out into mushroom-like limbs, dust filling the air as the wind meets it."),
    symbol = "7",
    color = "light_red",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("squish!"),
        terrain = "t_lichendirt",
        drops = { { item = "yum_lichen", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_tree_xeno",
    name = ccb.content.text("fossilized conifer"),
    description = ccb.content.text("A long dead tree standing on spindly legs similar to a Cypress which tapers into a point until spreading out in a hollow dodecahedron."),
    symbol = "7",
    color = "brown",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_deaddirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_xenoinfested",
    name = ccb.content.text("infested fossilized conifer"),
    description = ccb.content.text("A long dead tree standing on spindly legs similar to a Cypress which tapers into a point until spreading out in a hollow dodecahedron.  The trunk seems to be splitting as tendrils of mold dig into it, clinging onto the tree like a frame."),
    symbol = "7",
    color = "light_cyan",
    move_cost = 0,
    coverage = 60,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_deaddirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_lichenyum",
    name = ccb.content.text("lichen shrub"),
    description = ccb.content.text("A small mound of lichen grows here, noticeably bigger than the lichen and moss around it."),
    symbol = "i",
    color = "red",
    move_cost = 3,
    coverage = 20,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "FLAT", "THIN_OBSTACLE", "GRAZABLE" },
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "yum_lichen_harv" },
    },
    transforms_into = "t_lichen_harvested",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("squish."),
        terrain = "t_lichendirt",
        drops = { { item = "yum_lichen", count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_lichen_harvested",
    name = ccb.content.text("lichen shrub"),
    description = ccb.content.text("A small mound of lichen grows here, noticeably bigger than the lichen and moss around it.  A few clumps have been removed."),
    symbol = "i",
    color = "light_red",
    move_cost = 3,
    coverage = 20,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "FLAT", "THIN_OBSTACLE" },
    transforms_into = "t_lichenyum",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("squish."),
        terrain = "t_lichendirt",
        drops = { { item = "yum_lichen", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_shrub_moss",
    name = ccb.content.text("moss bush"),
    description = ccb.content.text("A mound of moss, with large colorful stems protruding out of it."),
    symbol = "#",
    color = "magenta",
    move_cost_mod = 8,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE_ASH", "THIN_OBSTACLE", "SHORT", "SHRUB" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("squish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_geo_mox",
    name = ccb.content.text("geothermal bladder"),
    description = ccb.content.text("Black veins support a large formation of bleached coral as it grows around the rim of this geothermal vent.  Above it, red and purple tentacles caress a balloon-shaped organ as it breathes."),
    symbol = "^",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = -1,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    emissions = { "emit_smoke_plume", "emit_hot_air_migo_seep" },
    bash = {
        minimum_strength = 65,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "rock", count = { 10, 22 } },
            { item = "sharp_rock", count = { 3, 7 } },
            { item = "material_limestone", count = { 2, 5 }, chance = 30 },
            { item = "material_rocksalt", count = { 0, 1 }, chance = 10 },
            { item = "material_rhodonite", count = { 0, 1 }, chance = 1 },
            { item = "afs_cryo_moxie_coral", count = { 1, 2 }, chance = 50 },
            { item = "material_zincite", count = { 0, 5 }, chance = 2 },
            { item = "alien_flesh", count = { 2, 5 }, chance = 50 },
            { item = "alien_fat", count = { 1, 3 }, chance = 30 },
            { item = "endochitin", count = { 2, 5 }, chance = 30 },
            { item = "alien_lung", count = { 0, 2 }, chance = 10 },
            { item = "alien_organs", count = { 1, 2 }, chance = 5 },
            { item = "chitin_piece", count = { 2, 5 }, chance = 10 },
        },
    },
}

ccb.content.define_furniture {
    id = "f_moxie_tube",
    name = ccb.content.text("breather"),
    description = ccb.content.text("On the ground here lay several colorless coral reefs, the black veins are noticeably more engorged as they breathe."),
    symbol = "+",
    color = "light_gray",
    move_cost_mod = 8,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT", "THIN_OBSTACLE", "SHORT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("squish."),
        drops = {
            { item = "chitin_piece", count = { 2, 5 }, chance = 10 },
            { item = "alien_organs", count = { 1, 2 }, chance = 5 },
            { item = "endochitin", count = { 2, 5 }, chance = 30 },
            { item = "alien_lung", count = { 0, 2 }, chance = 10 },
        },
    },
}

ccb.content.define_furniture {
    id = "f_moxie_vent",
    name = ccb.content.text("overgrown vent"),
    description = ccb.content.text("The coral and veins on the ground here have fused into a sea anemone-like structure; pufts of smoke and hot air emit from its mouth."),
    symbol = "o",
    color = "light_gray",
    move_cost_mod = 10,
    coverage = 40,
    required_strength = -1,
    emissions = { "emit_smoke_plume", "emit_hot_air_migo_seep" },
    flags = { "TRANSPARENT", "THIN_OBSTACLE", "SHORT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("squish."),
        drops = {
            { item = "chitin_piece", count = { 2, 5 }, chance = 10 },
            { item = "alien_organs", count = { 1, 2 }, chance = 5 },
            { item = "endochitin", count = { 2, 5 }, chance = 30 },
            { item = "alien_lung", count = { 0, 2 }, chance = 10 },
        },
    },
}
