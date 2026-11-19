local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_elder_ginseng",
    name = ccb.content.text("hundred year old ginseng"),
    description = ccb.content.text("The ginseng plant has leaves that grow in a circle around a straight stem.  Yellowish-green, umbrella-shaped flowers grow in the center and produce red berries.  Wrinkles around the neck of the root tell how old the plant is.  This plant is over a hundred years old and if you decide to harvest it, you will need the roots."),
    symbol = "*",
    color = "cyan",
    looks_like = "f_burdock",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "elder_ginseng_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_magic_brambles",
    name = ccb.content.text("brambles"),
    looks_like = "f_brambles",
    symbol = "#",
    background_color = "brown",
    description = ccb.content.text("A thick wall of tangled brambles grows here.  Vicious thorns protrude from the stems."),
    move_cost_mod = 8,
    coverage = 75,
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "BLOCKSDOOR",
        "PAINFUL",
        "SHARP",
        "PERMEABLE",
        "THIN_OBSTACLE",
        "SHRUB",
        "FLAMMABLE_ASH",
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 80,
        sound = ccb.content.text("smash"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "splinter", count = { 10, 15 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_arvore_translocator_ground",
    name = ccb.content.text("forest floor"),
    symbol = "+",
    looks_like = "t_forestfloor",
    description = ccb.content.text("A patch of forest like any other, but you could travel here from the depths of any forest you found yourself in."),
    color = "green",
    required_strength = -1,
    move_cost_mod = 0,
    flags = { "TRANSLOCATOR", "MOUNTABLE", "TRANSPARENT", "ALLOW_FIELD_EFFECT", "EASY_DECONSTRUCT" },
    builtin_examine = "translocator",
    deconstruct = { drops = {} },
}

ccb.content.define_terrain {
    id = "t_arvore_climbing_vine",
    name = ccb.content.text("climbing vine"),
    description = ccb.content.text("A thick vine, ascending straight up into the sky.  Its whorls and twists seem almost like naturally-formed handholds.  You could climb it if you want."),
    symbol = "|",
    looks_like = "t_bamboo_tall",
    color = "green",
    move_cost = 3,
    flags = { "TRANSPARENT", "THIN_OBSTACLE", "UNSTABLE", "CLIMBABLE", "FLAMMABLE_ASH" },
    bash = {
        minimum_strength = 5,
        maximum_strength = 12,
        sound = ccb.content.text("clang!"),
        failure_sound = ccb.content.text("clang."),
        terrain = "t_dirt",
        drops = { { item = "withered", count = { 40, 70 } } },
    },
}

ccb.content.define_furniture {
    id = "f_ozma_poppy",
    name = ccb.content.text("Ozma's emerald poppy"),
    description = ccb.content.text("These strange flowers have appeared in the wake of the Cataclysm, and their buds can be used for medicinal purposes, like the buds of the mundane poppy they're named after.  The dirt around it gently churns as its roots writhe beneath the soil, and it's surrounded by an overwhelming floral smell that makes you feel sleepy."),
    symbol = "f",
    color = "green",
    looks_like = "f_mutpoppy",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "flower_poppy",
    emissions = { "emit_emerald_poppy_pollen" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}
