local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "elevator_shop_base",
    layout = {
        terrain = { ["#"] = "t_concrete_wall" },
        furniture = {
            F = "f_glass_fridge",
            O = "f_oven",
            c = "f_counter",
            d = "f_displaycase",
            h = "f_chair",
            s = "f_barstool",
        },
    },
}

-- TODO: These all need more groups and different items
ccb.content.define_mapgen_palette {
    id = "elevator_shop_drink",
    layout = {
        item_groups = {
            F = { { group = "elevator_fridge_drink", chance = 50, repetitions = { 1, 3 } } },
            d = { { group = "elevator_fridge_drink", chance = 50, repetitions = { 1, 3 } } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "elevator_shop_food",
    layout = {
        item_groups = {
            F = { { group = "elevator_fridge_food", chance = 50, repetitions = { 1, 3 } } },
            d = { { group = "elevator_fridge_food", chance = 50, repetitions = { 1, 3 } } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "elevator_shop_luxury",
    layout = {
        item_groups = {
            F = { { group = "elevator_fridge_drink", chance = 50, repetitions = { 1, 3 } } },
            d = { { group = "elevator_fridge_food", chance = 50, repetitions = { 1, 3 } } },
        },
    },
}
