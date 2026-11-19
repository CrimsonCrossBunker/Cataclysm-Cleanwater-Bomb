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
