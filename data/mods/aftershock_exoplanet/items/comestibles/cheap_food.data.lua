local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_h2o",
    name = ccb.content.plural_text("H₂O™", "H₂O™"),
    copy_from = "water_clean",
    default_container = "can_drink",
    description = ccb.content.text("When Thistle Industries successfully trademarked the chemical formula of water, you thought the world had gone irreparably insane, but things have only gotten worse since."),
    comestible = {},
}

ccb.content.define_item {
    id = "afs_food_cube",
    name = ccb.content.plural_text("food cubes", "food cubes"),
    symbol = "f",
    default_container = "bag_plastic_small",
    copy_from = "protein_bar_evac",
    color = "white",
    description = ccb.content.text("Smoothly blended edibles, neatly shaped into cubes for maximum enjoyment."),
    volume = "111 ml",
    comestible = {
        calories = 700,
        healthy = 3,
        fun = 2,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 30 },
            { id = "iron", amount = 30 },
            { id = "vitC", amount = 30 },
            { id = "bad_food", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_food_to_go",
    name = ccb.content.plural_text("Foodplace's Food-to-go™", "Foodplace's Food-to-go™"),
    default_container = "bag_plastic_small",
    symbol = "f",
    copy_from = "protein_bar_evac",
    color = "magenta",
    description = ccb.content.text("Foodplace™ easy-storage Food-to-go™ the choice Food™ for the contemporary Foodman™."),
    volume = "111 ml",
    comestible = { calories = 500, healthy = 3, fun = 2, freezing_point = -9999 },
}

ccb.content.define_item {
    id = "afs_loop_fruit",
    name = ccb.content.plural_text("loop 'fruit'", "loop 'fruit'"),
    default_container = "bag_plastic_small",
    copy_from = "protein_bar_evac",
    color = "white",
    description = ccb.content.text("Rings of caramelized yellow colorant, tasting not exactly like apple."),
    comestible = {
        calories = 200,
        healthy = 3,
        fun = 2,
        freezing_point = -9999,
        vitamins = { { id = "iron", amount = 1 }, { id = "vitC", amount = 10 } },
    },
}

ccb.content.define_item {
    id = "afs_cee_wafers",
    name = ccb.content.plural_text("cee wafers", "cee wafers"),
    default_container = "can_food",
    copy_from = "protein_bar_evac",
    color = "white",
    materials = { "veggy" },
    description = ccb.content.text("Smooth crackers colored grayish-green.  Used to be perfectly edible seaweed, or so the wrapper claims."),
    volume = "74 ml",
    comestible = {
        calories = 150,
        healthy = 3,
        fun = 2,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 5 },
            { id = "vitC", amount = 10 },
            { id = "bad_food", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_beefsim",
    name = ccb.content.plural_text("beefsim", "beefsim"),
    default_container = "can_food",
    copy_from = "protein_bar_evac",
    color = "red",
    materials = { "flesh", "veggy" },
    description = ccb.content.text("Soy or pureed rat?  Better not to know.\n(But its probably both.)"),
    volume = "111 ml",
    comestible = {
        calories = 250,
        healthy = 3,
        fun = 0,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 5 },
            { id = "vitC", amount = 10 },
            { id = "bad_food", amount = 1 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_soup_27",
    name = ccb.content.plural_text("soup, flavor 27", "soup, flavor 27"),
    copy_from = "soup_cullenskink",
    default_container = "can_food",
    color = "red",
    materials = { "flesh", "veggy" },
    description = ccb.content.text("Yellow chunks float on creamy liquid, like flotsam on a filthy summer pond.  Branding implies at least 26 other flavors, but you have neither seen or heard about any of them."),
    comestible = {
        calories = 450,
        healthy = 3,
        fun = 0,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 10 },
            { id = "vitC", amount = 5 },
            { id = "bad_food", amount = 1 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_escapepod_ration",
    name = ccb.content.plural_text("landfall survival rations", "landfall survival rations"),
    symbol = "o",
    default_container = "bag_plastic_small",
    copy_from = "protein_bar_evac",
    color = "white",
    description = ccb.content.text("Sealed emergency rations invariably found within an escape pod's inventory.  This particular pack should provide around a day's worth of nutrition.  Required by regulation but rarely ever used, the design of these \"meals\" prioritizes a long shelf life and a very low bulk-cost.  Which lends them their disgusting taste of greased sawdust."),
    volume = "55 ml",
    comestible = {
        calories = 500,
        healthy = 3,
        fun = -2,
        freezing_point = -9999,
        vitamins = { { id = "vitC", amount = 2 }, { id = "bad_food", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "afs_caffex",
    name = ccb.content.plural_text("caffex", "caffex"),
    copy_from = "coffee",
    default_container = "can_drink",
    description = ccb.content.text("A dark and soapy beverage, pre-brewed and loaded with synthetic caffeine."),
    comestible = {
        calories = 150,
        healthy = -3,
        fun = 6,
        freezing_point = -9999,
        vitamins = { { id = "bad_food", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "afs_ruined_food",
    copy_from = "ruined_chunks",
    name = ccb.content.plural_text("organic sludge", "organic sludge"),
    volume = "100 ml",
    mass = "50 g",
    description = ccb.content.text("Time and the elements have reverted this heavily processed meal to its original form.  Eating it isn't even worth thinking about."),
    materials = { "flesh", "veggy" },
    comestible = {
        kind = "FOOD",
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "veggy_allergen", amount = 1 } },
    },
}
