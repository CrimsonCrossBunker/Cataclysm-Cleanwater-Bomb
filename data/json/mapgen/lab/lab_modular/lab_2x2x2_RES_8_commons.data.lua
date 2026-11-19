local ccb = require("ccb")

-- combines 2 5x5 convenience shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_convenience_shop_front_A", x = 0, y = 0 },
            { id = "lab_5x5_convenience_shop_front_B", x = 0, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 convenience shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_convenience_shop_front_A", x = 1, y = 0 },
            { id = "lab_5x5_convenience_shop_front_B", x = 1, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 pizza shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_pizza_shop_front_A", x = 0, y = 0 },
            { id = "lab_5x5_pizza_shop_front_B", x = 0, y = 5 },
            { id = "lab_6x6_pizza_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 pizza shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_pizza_shop_front_A", x = 1, y = 0 },
            { id = "lab_5x5_pizza_shop_front_B", x = 1, y = 5 },
            { id = "lab_6x6_pizza_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 Mexican restaurant areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_restaurant_mexican_front_A", x = 0, y = 0 },
            { id = "lab_5x5_restaurant_mexican_front_B", x = 0, y = 5 },
            { id = "lab_6x6_restaurant_mexican_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 Mexican restaurant areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_restaurant_mexican_front_A", x = 1, y = 0 },
            { id = "lab_5x5_restaurant_mexican_front_B", x = 1, y = 5 },
            { id = "lab_6x6_restaurant_mexican_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 coffee shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_coffee_shop_front_A", x = 0, y = 0 },
            { id = "lab_5x5_coffee_shop_front_B", x = 0, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 coffee shop areas and a 6x6 back room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_coffee_shop_front_A", x = 1, y = 0 },
            { id = "lab_5x5_coffee_shop_front_B", x = 1, y = 5 },
            { id = "lab_6x6_shop_backroom", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 bar areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_bar_front_A", x = 0, y = 0 },
            { id = "lab_5x5_bar_front_B", x = 0, y = 5 },
            { id = "lab_6x6_bar_kitchen", x = 0, y = 11 },
        },
    },
}

-- combines 2 5x5 bar areas and a 6x6 kitchen.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_17x17_shop_2",
    layout = {
        size = { width = 17, height = 17 },
        nested = {
            { id = "lab_5x5_bar_front_A", x = 1, y = 0 },
            { id = "lab_5x5_bar_front_B", x = 1, y = 5 },
            { id = "lab_6x6_bar_kitchen", x = 0, y = 11 },
        },
    },
}
