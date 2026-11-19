local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_pallet_brick",
    name = ccb.content.text("pallet of bricks"),
    looks_like = "t_brick_wall",
    description = ccb.content.text("A massive, packed-together block of bricks wrapped with plastic packaging.  It makes for easy storage of building materials for masonry constructions."),
    symbol = "#",
    color = "brown",
    move_cost_mod = 5,
    required_strength = -1,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "REDUCE_SCENT", "EASY_DECONSTRUCT", "SMALL_HIDE" },
    deconstruct = {
        drops = {
            { item = "brick", count = 400 },
            { item = "pallet", count = 1 },
            { item = "plastic_sheet", count = 1 },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 100,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("bash!"),
        drops = {
            { item = "pallet", count = 1 },
            { item = "brick", count = { 300, 350 } },
            { item = "brick", count = { 30, 50 }, damage = { 1, 6 } },
            { item = "plastic_sheet", count = 1, damage = { 2, 5 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_pallet_brick_adobe",
    name = ccb.content.text("pallet of adobe bricks"),
    looks_like = "t_adobe_brick_wall",
    description = ccb.content.text("A massive, packed-together block of adobe bricks wrapped with plastic packaging.  It makes for easy storage of building materials for masonry constructions."),
    symbol = "#",
    color = "brown",
    move_cost_mod = 5,
    required_strength = -1,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "REDUCE_SCENT", "EASY_DECONSTRUCT", "SMALL_HIDE" },
    deconstruct = {
        drops = {
            { item = "adobe_brick", count = 400 },
            { item = "pallet", count = 1 },
            { item = "plastic_sheet", count = 1 },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 100,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("bash!"),
        drops = {
            { item = "pallet", count = 1 },
            { item = "adobe_brick", count = 350 },
            { item = "adobe_brick", count = 50, damage = { 1, 4 } },
            { item = "plastic_sheet", count = 1, damage = { 2, 4 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_pallet_cement",
    name = ccb.content.text("pallet of cement bags"),
    looks_like = "material_cement",
    description = ccb.content.text("A massive, packed-together block of cement bags wrapped with plastic packaging.  It makes for easy storage of building materials for masonry constructions."),
    symbol = "#",
    color = "light_gray",
    move_cost_mod = 5,
    required_strength = -1,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "REDUCE_SCENT", "EASY_DECONSTRUCT", "SMALL_HIDE" },
    deconstruct = {
        drops = {
            { group = "cement_bag", count = 64 },
            { item = "pallet", count = 1 },
            { item = "plastic_sheet", count = 1 },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 100,
        sound = ccb.content.text("thump!"),
        failure_sound = ccb.content.text("thud!"),
        drops = {
            { group = "cement_bag", count = 60 },
            { item = "material_cement", count = { 500, 1500 } },
            { item = "bag_durasack", count = { 2, 10 }, damage = { 1, 5 } },
            { item = "pallet", count = 1 },
        },
    },
}

ccb.content.define_furniture {
    id = "f_stack_plank",
    name = ccb.content.text("stack of wooden planks"),
    looks_like = "bundle_plank",
    description = ccb.content.text("Dozens of construction planks tied together for easier transport.  Deconstruct to untie them."),
    symbol = "#",
    color = "light_gray",
    move_cost_mod = 5,
    required_strength = -1,
    coverage = 40,
    flags = {
        "TRANSPARENT",
        "NOITEM",
        "MOUNTABLE",
        "REDUCE_SCENT",
        "EASY_DECONSTRUCT",
        "FLAMMABLE_ASH",
        "SMALL_HIDE",
    },
    deconstruct = {
        drops = {
            { item = "2x4", count = 120 },
            { item = "rope_6", count = 2 },
            { item = "pallet", count = 1 },
        },
    },
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        drops = {
            { item = "2x4", count = { 90, 100 } },
            { item = "2x4", count = { 2, 20 } },
            { item = "pallet", count = 1 },
            { item = "rope_6", count = { 1, 2 }, damage = { 1, 5 } },
        },
    },
}
