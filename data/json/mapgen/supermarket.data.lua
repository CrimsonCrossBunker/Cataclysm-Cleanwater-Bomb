local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = {
        { "supermarket_x0_y0_z1", "supermarket_x0_y1_z1", "supermarket_x0_y2_z1" },
        { "supermarket_x1_y0_z1", "supermarket_x1_y1_z1", "supermarket_x1_y2_z1" },
        { "supermarket_x2_y0_z1", "supermarket_x2_y1_z1", "supermarket_x2_y2_z1" },
    },
    layout = {
        rows = {
            "-----------------------------------------------                         ",
            "-.............................................5   5--------             ",
            "-.............................................-   -.......-             ",
            "-...A..........A..............................-   -.......-             ",
            "-.............................................-   -.......-             ",
            "-.............................................-   ---------             ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-...A..........A..............................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.......&.............&.............&.........-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-..............=..............=...............-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.......&.............&.............&.........-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-..............=..............=...............-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.......&.............&.............&......XN.-                         ",
            "-...........................................X.-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-.............................................-                         ",
            "-----------------------------------------------                         ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
            "                                                                        ",
        },
        palettes = { "roof_palette" },
        terrain = {
            X = "t_flat_roof",
            N = "t_flat_roof",
            ["&"] = "t_flat_roof",
            ["="] = "t_flat_roof",
            A = "t_flat_roof",
        },
        fill_terrain = "t_open_air",
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pallet_supermarket_interior",
    layout = {
        size = { width = 1, height = 1 },
        item_placements = { { id = "pallet", x = 0, y = 0 } },
        item_group_placements = { { group = "any_supermarket_SUS", x = 0, y = 0, chance = 50 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pallet_supermarket_exterior",
    layout = {
        size = { width = 1, height = 1 },
        item_placements = { { id = "pallet", x = 0, y = 0 } },
        item_group_placements = { { group = "cardboards", x = 0, y = 0, chance = 50 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_sauces_dressings",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_sauces_dressings", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_exotic_food",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_exotic_food", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_spices_seasoning",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_spices_seasoning", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_oil_vinegar",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_oil_vinegar", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_grains",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_grains", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_baking",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_baking", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_pasta",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_pasta", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_canned_vegetables",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_canned_vegetables", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_canned_fruits",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_canned_fruits", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_canned_meat",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_canned_meat", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_canned_meals",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_canned_meals", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_coffee",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_coffee", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_tea",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_tea", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_breakfast_cereal",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_breakfast_cereal", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_breakfast_mixes",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_breakfast_mixes", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_spreads",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_spreads", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_sweet_snacks",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_sweet_snacks", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_butter_cream",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_butter_cream", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_yoghurt",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_yoghurt", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_cheese",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_cheese", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_milk",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_milk", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_eggs",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_eggs", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_deli",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_deli", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_meat_beef",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_meat_beef", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_meat_pork",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_meat_pork", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_meat_poultry",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_meat_poultry", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_meat_seafood",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_meat_seafood", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_icecream",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_icecream", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_frozen_dessert",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_frozen_dessert", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_water",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_water", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_soda",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_soda", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_juices",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_juices", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_sports_drink",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_sports_drink", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_chips",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_chips", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_nuts_crackers",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_nuts_crackers", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_chocolate",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_chocolate", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_candy",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_candy", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_pet_food_in_container",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_pet_food_in_container", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_pet_accessories",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_pet_accessories", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_baby_accessories_food",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_baby_accessories_food", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_baby_hygiene",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_baby_hygiene", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_office_supplies",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_office_supplies", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_electronics_accessories",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_electronics_accessories", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_books",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_books", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_magazines",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_magazines", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_laundry",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_laundry", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_dish_cleaning",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_dish_cleaning", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_cleaning_supplies",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_cleaning_supplies", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_toilet_paper",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_toilet_paper", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_dental_care",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_dental_care", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_drugs",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_drugs", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_shower_supplies",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_shower_supplies", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_personal_care",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_personal_care", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_vegetables",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_vegetables", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_fruits",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_fruits", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_bread_specialty",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_bread_specialty", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_bread_sweet",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_bread_sweet", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_bread",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_bread", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_frozen_vegetables",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_frozen_vegetables", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_frozen_meals",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_display_fridge", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_commercial_frozen_meals", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shelf_commercial_special_seasonal",
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_warehouse_shelf", x = 0, y = 0 } },
        item_group_placements = { { group = "SUS_shelf_any", x = 0, y = 0 } },
    },
}

-- The shelves are using various greek and cyrillic characters, not in any particular order.
ccb.content.define_mapgen {
    kind = "overmap",
    id = {
        { "supermarket_x0_y0_z0", "supermarket_x0_y1_z0", "supermarket_x0_y2_z0" },
        { "supermarket_x1_y0_z0", "supermarket_x1_y1_z0", "supermarket_x1_y2_z0" },
        { "supermarket_x2_y0_z0", "supermarket_x2_y1_z0", "supermarket_x2_y2_z0" },
    },
    layout = {
        rows = {
            "#######################55######################KKKKKKKKKKKKKKKKKKKKKKKKK",
            "#zzzzzzzzzzzzzzz#9999#J--HHHHHHHHHHHHHHHHHHHHH#^.^#########..........R++",
            "#---------------#9---#H-----------------H-HH-H#.............nnnnnnnn.R++",
            "#---------------#9---#H-----------------H-HH-H#R...M..M..M..nnnnnnnn..++",
            "#zzzzzz--zzzzzzz#9---#H--HHHHHHHHHHHHH--H-HH-H#R............nnnnnnnn.R++",
            "#######11##########D##H--HHHHHHHHHHHHH--------#...#.......#..........R++",
            "#XXX#ZZ--ZZZZZZZ#-----------------------------#.........................",
            "#X--D-----------1-----------------------mmmm--|.........................",
            "#X-X#-----------1--#D#####--HHHHHHHHHH--mmmm--|..................Ẅ......",
            "##D##ZZZZZZZZZZZ#--#-N#ee#--HHHHHHHHHH--mmmm--|.........................",
            "#k-B#############--#-N#--#--------------mmmm--|......Ẃ..................",
            "#c-B#cccck#--------#--D--D--------------mmmm--|...................*****.",
            "#c--D-----D--------#NN#QQ#--HHHHHHHHHH-------3#3................*******.",
            "#####bbbbb################55##########--------D.................**......",
            "#jΣΣ§      ΣΣΣΣΣΣΣΣΣΣΣΣΣΣΣ  ΣΣΣΣΣΣΣΣΣ#--#######................**.......",
            "5                                   Σ#--#LLLLL#.........................",
            "5                                   Σ#--D-----#................**.......",
            "#ε  ӞΏ  ΔЖ  ӜӨ  Фϕ  ӘΛ  Чξ  Цπ  Π↋  ϗ#--#######................**.......",
            "#ε  ӞΏ  ΔЖ  ӜӨ  Фϕ  ӘΛ  Чξ  Цπ  Π↋  ϗ#--#LLLLL#++*******.......**.......",
            "#ε  ӞΏ  ΔЖ  ӜӨ  Фϕ  ӘΛ  Чξ  Цπ  Π↋  ϗ#--D-----#+i*......==............++",
            "#ε  ӞΏ  ΔЖ  ӜӨ  Фϕ  ӘΛ  Чξ  Цπ  Π↋  ϗ#--#######++*.............**.....++",
            "#ε  ӞΏ  ΔЖ  ӜӨ  Фϕ  ӘΛ  Чξ  Цπ  Π↋  ϗ#--#-t#-t#+i*..Ú...==.....**.....++",
            "#δ  ӟΩ  ζж  ӝө  фϖ  әБ  ӵη  цΞ  п↊  ϗ#--#-e#-e#++*.............**.....++",
            "#δ  ӟΩ  ζж  ӝө  фϖ  әБ  ӵη  цΞ  п↊  ϗ#--#D##D##+i*******==............++",
            "#δ  ӟΩ  ζж  ӝө  фϖ  әБ  ӵη  цΞ  п↊  ϗ#--D-----#++*.............**.....++",
            "#δ  ӟΩ  ζж  ӝө  фϖ  әБ  ӵη  цΞ  п↊  ϗ#--#######++*......==.....**.....++",
            "#δ  ϏϏ  ζж  ӝө  фϖ  ϏϏ  ӵη  цΞ  п↊  ϗ#--#ppddd#+i*..Ú..........**.....++",
            "#δ                                   5--D--dhu4++*......==............++",
            "#Ш                         ________  5--#----u#+i*******.......**.....++",
            "#Ш  ЏЪ  ЮИ  ϏϏ  ҰΓ  ҐЄ  ЭЯ _ββ__ββ_ λ#--#######++*......==.....**.....++",
            "#Ш  ЏЪ  ЮИ  ΌЌ  ҰΓ  ҐЄ  ЭЯ _ββ__ββ_ λ#--#dhdhu#+i*.............**.....++",
            "#Ш  ЏЪ  ЮИ  ΌЌ  ҰΓ  ҐЄ  ЭЯ _ββ__ββ_ λ#--#d-d-u4++*..Ú...==............++",
            "#Ш  ЏЪ  ЮИ  ΌЌ  ҰΓ  ҐЄ  ЭЯ ________ λ#--D----u#+i*.............**.....++",
            "#Ш  ЏЪ  ЮИ  ΌЌ  ҰΓ  ҐЄ  ЭЯ ________ λ#--#d-d-u4++*******==.....**.....++",
            "#ш  џъ  юи  Дќ  ұ૪  ґє  эя _λλ__λλ_ λ#--#dhdhu#+i*.............**.....++",
            "#ш  џъ  юи  Дќ  ұ૪  ґє  эя _λλ__λλ_ λ#D########++*......==............++",
            "#ш  џъ  юи  Дќ  ұ૪  ґє  эя _λλ__λλ_ λ#-keaaafg#+i*..Ú..........**.....++",
            "#ш  џъ  юи  Дќ  ұ૪  ґє  эя ________ §#--------4++*......==.....**.....++",
            "#j  џъ  юи  Дќ  ұ૪  ґє  эя          Ђ#s-hThhTh#+i*******.......**.....++",
            "5                           QQQQ    Ђ#s-hThhTh4++*iiiiii==............++",
            "5  §                        q 2Q  ЂЂЂ#sshThhTh#+i*i$$..........**.....++",
            "##D#E QCE QCE QCE QCE QCE QCQ2##xx#############++*i$$$..==.....**.....++",
            "#W-#E Q2E Q2E Q2E Q2E Q2E Q2QQ#y__y__£££££££££[++*iiiiii.......**.....++",
            "#W-#                          x_______________x+i.=.=.=.==............++",
            "#W-#                          x_______________x++.=.=.=.==.....**.....++",
            "#Ww#§Y Y Y Y Y Y Y Y Y Y Y Y Y#y__y___££££££££[+i..............**.....++",
            "####[[[[[[[[[[[[[[[[[[[[[[[[[[[[xx[[[[[[[[[[[[[++..............**.....++",
            "K+++++++++++++++++++++++++++++++++++++++++++++++i.....................++",
            "K++++i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i+i...............**.....++",
            "K++++*****************************==***********................**.....++",
            "K++++....*....*....*....*....*iiii==*....*....*................**.....++",
            "K++++....*....*....*....*....*i¢¢i..*....*....*.......................++",
            "K++++.Ù..*.Ù..*.Ù..*.Ù..*.Ù..*i¢¢i==*.Ù..*.Ù..*................**.....++",
            "K++++....*....*....*....*....*i¢¢i..*....*....*................**.....++",
            "K++++....*....*....*....*....*i.¢i==*....*....*................**.....++",
            "K++++....*....*....*....*....*i..i..*....*....*.......................++",
            "K++++.=.=.=.=.=.=.=.=.=.=.=.=.=.=.==.=.=.=.=.=.................**.....++",
            "K++++.=.=.=.=.=.=.=.=.=.=.=.=.=.=.==.=.=.=.=.=.................**.....++",
            "K++++..........................................................**.....++",
            "K++++.........................................................**......++",
            "K++++.........................................................**......++",
            "K++++........................................................**.......++",
            "K++++......................................................***........++",
            "K++++........***.***.***.***.***.***..***.***.***.***.***.***.........++",
            "K++++........***.***.***.***.***.***..***.***.***.***.***.*...........++",
            "K++++...............................**................................++",
            "K+++++..............................**...............................+++",
            "K+++++..............................**...............................+++",
            "K++++++.............................................................++++",
            "K++++++++...........................**............................++++++",
            "K++++++++++++++++++++++++++++......**.......++++++++++++++++++++++++++++",
            "K++++++++++++++++++++++++++++......**.......++++++++++++++++++++++++++++",
        },
        toilets = { "t" },
        nested_glyphs = {
            ["Ώ"] = { id = "shelf_commercial_sauces_dressings" },
            ["Ω"] = { id = "shelf_commercial_spices_seasoning" },
            ["Δ"] = { id = "shelf_commercial_oil_vinegar" },
            ["ζ"] = { id = "shelf_commercial_exotic_food" },
            ["Ж"] = { id = "shelf_commercial_grains" },
            ["ж"] = { id = "shelf_commercial_grains" },
            ["Ӝ"] = { id = "shelf_commercial_baking" },
            ["ӝ"] = { id = "shelf_commercial_pasta" },
            ["Ө"] = { id = "shelf_commercial_canned_vegetables" },
            ["ө"] = { id = "shelf_commercial_canned_fruits" },
            ["Ф"] = { id = "shelf_commercial_canned_meat" },
            ["ф"] = { id = "shelf_commercial_canned_meals" },
            ["ϕ"] = { id = "shelf_commercial_coffee" },
            ["ϖ"] = { id = "shelf_commercial_tea" },
            ["Ә"] = { id = "shelf_commercial_breakfast_cereal" },
            ["ә"] = { id = "shelf_commercial_breakfast_mixes" },
            ["Λ"] = { id = "shelf_commercial_spreads" },
            ["Б"] = { id = "shelf_commercial_sweet_snacks" },
            ["Ч"] = { id = "shelf_commercial_butter_cream" },
            ["ӵ"] = { id = "shelf_commercial_yoghurt" },
            ["ξ"] = { id = "shelf_commercial_cheese" },
            ["η"] = { id = "shelf_commercial_milk" },
            ["Ц"] = { id = "shelf_commercial_eggs" },
            ["ц"] = { id = "shelf_commercial_deli" },
            ["π"] = { id = "shelf_commercial_meat_beef" },
            ["Ξ"] = { id = "shelf_commercial_meat_pork" },
            ["Π"] = { id = "shelf_commercial_meat_poultry" },
            ["п"] = { id = "shelf_commercial_meat_seafood" },
            ["↋"] = { id = "shelf_commercial_icecream" },
            ["↊"] = { id = "shelf_commercial_frozen_dessert" },
            ["ε"] = { id = "shelf_commercial_water" },
            ["δ"] = { id = "shelf_commercial_water" },
            ["Ӟ"] = { id = "shelf_commercial_soda" },
            ["ӟ"] = { id = "shelf_commercial_soda" },
            ["Ш"] = { id = "shelf_commercial_juices" },
            ["ш"] = { id = "shelf_commercial_sports_drink" },
            ["Џ"] = { id = "shelf_commercial_soda" },
            ["џ"] = { id = "shelf_commercial_soda" },
            ["Ъ"] = { id = "shelf_commercial_chips" },
            ["ъ"] = { id = "shelf_commercial_nuts_crackers" },
            ["Ю"] = { id = "shelf_commercial_chocolate" },
            ["ю"] = { id = "shelf_commercial_candy" },
            ["И"] = { id = "shelf_commercial_pet_food_in_container" },
            ["и"] = { id = "shelf_commercial_pet_accessories" },
            ["Ό"] = { id = "shelf_commercial_baby_accessories_food" },
            ["Д"] = { id = "shelf_commercial_baby_hygiene" },
            ["Ќ"] = { id = "shelf_commercial_office_supplies" },
            ["ќ"] = { id = "shelf_commercial_electronics_accessories" },
            ["Ұ"] = { id = "shelf_commercial_books" },
            ["ұ"] = { id = "shelf_commercial_magazines" },
            ["Γ"] = { id = "shelf_commercial_laundry" },
            ["૪"] = { id = "shelf_commercial_dish_cleaning" },
            ["Ґ"] = { id = "shelf_commercial_cleaning_supplies" },
            ["ґ"] = { id = "shelf_commercial_toilet_paper" },
            ["Є"] = { id = "shelf_commercial_dental_care" },
            ["є"] = { id = "shelf_commercial_drugs" },
            ["Э"] = { id = "shelf_commercial_shower_supplies" },
            ["э"] = { id = "shelf_commercial_personal_care" },
            ["β"] = { id = "shelf_commercial_vegetables" },
            ["λ"] = { id = "shelf_commercial_fruits" },
            ["Я"] = { id = "shelf_commercial_bread_specialty" },
            ["я"] = { id = "shelf_commercial_bread_sweet" },
            ["Ђ"] = { id = "shelf_commercial_bread" },
            ["Σ"] = { id = "shelf_commercial_frozen_meals" },
            ["ϗ"] = { id = "shelf_commercial_frozen_vegetables" },
            ["Ϗ"] = { id = "shelf_commercial_special_seasonal" },
            m = {
                choices = { { id = "pallet_supermarket_interior", weight = 1 }, { id = "null", weight = 1 } },
            },
            n = {
                choices = { { id = "pallet_supermarket_exterior", weight = 1 }, { id = "null", weight = 1 } },
            },
            ["§"] = { id = "fire_extinguisher" },
        },
        item_spawns = { w = { id = "bot_hazmatbot" } },
        item_groups = {
            W = { group = "SUS_janitors_closet" },
            H = { group = "SUS_shelf_any" },
            C = { group = "cash_register_random" },
            E = { group = "cash_register_impulse_buy_general" },
            N = { group = "SUS_shelf_commercial_vegetables", repetitions = { 0, 2 } },
            z = { group = "any_supermarket_SUS_freezer" },
            Z = { group = "any_supermarket_SUS_fridge" },
            X = {
                { group = "SUS_shelf_commercial_meat_beef", chance = 50, repetitions = { 1, 2 } },
                { group = "SUS_shelf_commercial_meat_pork", chance = 50, repetitions = { 1, 2 } },
                { group = "SUS_shelf_commercial_meat_poultry", chance = 50, repetitions = { 1, 2 } },
            },
            b = {
                { group = "SUS_shelf_commercial_meat_beef", chance = 50 },
                { group = "SUS_shelf_commercial_meat_pork", chance = 50 },
                { group = "SUS_shelf_commercial_meat_poultry", chance = 50 },
            },
            t = { group = "SUS_toilet" },
            p = { group = "SUS_business_bookcase" },
            f = { group = "SUS_fridge" },
            e = { group = "public_sink" },
            a = {
                { group = "SUS_dishes", chance = 20 },
                { group = "SUS_cookware", chance = 20 },
                { group = "SUS_appliances_cupboard", chance = 20 },
                { group = "SUS_coffee_cupboard", chance = 20 },
                { group = "SUS_breakfast_cupboard", chance = 20 },
                { group = "SUS_spice_collection", chance = 20 },
            },
            L = { group = "fast_locker" },
            d = { group = "SUS_office_desk" },
            u = { group = "SUS_office_filing_cabinet" },
            j = { group = "fireman_cabinet" },
        },
        vehicle_glyphs = {
            ["Ü"] = { chance = 33, id = "parking_garage" },
            ["Û"] = { chance = 33, id = "parking_garage", rotation = 90 },
            ["Ú"] = { chance = 33, id = "parking_garage", rotation = 180 },
            ["Ù"] = { chance = 33, id = "parking_garage", rotation = 270 },
            ["Ẃ"] = { chance = 33, id = "truck_trailer" },
            ["Ẅ"] = { chance = 33, id = "semi_truck" },
            M = { chance = 50, id = "forklift", rotation = 90 },
            ["$"] = { id = "shopping_cart" },
            ["£"] = { id = "shopping_cart" },
            ["¢"] = { id = "shopping_cart", rotation = 90 },
        },
        monster_group_placements = {
            { group = "GROUP_ZOMBIE", x = { 0, 23 }, y = { 0, 23 }, density = 0.1 },
            { group = "GROUP_ZOMBIE", x = { 24, 47 }, y = { 0, 23 }, density = 0.1 },
            { group = "GROUP_ZOMBIE", x = { 48, 71 }, y = { 0, 23 }, density = 0.5 },
            { group = "GROUP_ZOMBIE", x = { 0, 23 }, y = { 24, 47 }, density = 0.5 },
            { group = "GROUP_ZOMBIE", x = { 24, 47 }, y = { 24, 47 }, density = 0.5 },
            { group = "GROUP_ZOMBIE", x = { 48, 71 }, y = { 24, 47 }, density = 0.5 },
            { group = "GROUP_ZOMBIE", x = { 0, 23 }, y = { 48, 71 }, density = 0.5 },
            { group = "GROUP_ZOMBIE", x = { 24, 47 }, y = { 48, 71 }, density = 0.5 },
            { group = "GROUP_ZOMBIE", x = { 48, 71 }, y = { 48, 71 }, density = 0.5 },
        },
        fill_terrain = "t_floor",
        palettes = { "parametrized_walls_palette", "parametrized_carpets_palette" },
        terrain = {
            ["."] = "t_pavement",
            ["$"] = "t_pavement",
            ["¢"] = "t_pavement",
            ["Ü"] = "t_pavement",
            ["Ù"] = "t_pavement",
            ["Ú"] = "t_pavement",
            ["Û"] = "t_pavement",
            ["Ẃ"] = "t_pavement",
            ["Ẅ"] = "t_pavement",
            R = "t_pavement",
            n = "t_pavement",
            M = "t_pavement",
            ["*"] = "t_pavement_y",
            ["="] = "t_zebra",
            ["+"] = "t_sidewalk",
            Q = "t_floor",
            C = "t_floor",
            j = "t_floor",
            a = "t_linoleum_gray",
            ["-"] = "t_linoleum_gray",
            d = "t_linoleum_gray",
            f = "t_linoleum_gray",
            T = "t_linoleum_gray",
            J = "t_linoleum_gray",
            m = "t_linoleum_gray",
            P = "t_linoleum_gray",
            p = "t_linoleum_gray",
            L = "t_linoleum_gray",
            t = "t_linoleum_gray",
            ["9"] = "t_linoleum_gray",
            G = "t_linoleum_gray",
            h = "t_linoleum_gray",
            H = "t_linoleum_gray",
            F = "t_linoleum_gray",
            B = "t_linoleum_gray",
            b = "t_linoleum_gray",
            W = "t_linoleum_gray",
            w = "t_linoleum_gray",
            c = "t_linoleum_gray",
            u = "t_linoleum_gray",
            s = "t_linoleum_gray",
            g = "t_linoleum_gray",
            k = "t_linoleum_gray",
            Z = "t_linoleum_gray",
            D = "t_door_c",
            x = "t_door_glass_c",
            ["1"] = "t_door_metal_c",
            ["5"] = "t_door_metal_c",
            ["["] = "t_wall_glass",
            ["|"] = "t_door_metal_locked",
            _ = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["£"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["λ"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            K = "t_chainfence",
            i = "t_metal_railing",
            ["3"] = "t_gates_control_concrete_lab",
            ["4"] = "t_window_no_curtains",
            ["^"] = "t_gutter_downspout",
        },
        furniture = {
            ["2"] = "f_chair",
            ["9"] = "f_water_heater",
            a = "f_counter",
            B = "f_metal_butcher_rack",
            b = "f_counter",
            c = "f_counter",
            d = "f_desk",
            E = "f_rack",
            e = "f_sink",
            F = "f_freezer",
            f = "f_oven",
            g = "f_fridge",
            H = "f_warehouse_shelf",
            h = "f_chair",
            k = "f_trashcan",
            L = "f_locker",
            N = "f_warehouse_shelf",
            p = "f_bookcase",
            Q = "f_counter",
            C = "f_table",
            q = "f_counter_gate_c",
            R = "f_dumpster",
            s = "f_sofa",
            T = "f_table",
            u = "f_filing_cabinet",
            W = "f_rack",
            X = "f_warehouse_shelf",
            Y = "f_indoor_plant",
            y = "f_indoor_plant",
            Z = "f_warehouse_shelf",
            z = "f_warehouse_shelf",
        },
    },
}
