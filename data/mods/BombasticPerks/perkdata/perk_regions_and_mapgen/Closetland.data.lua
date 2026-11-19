local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "closetland_nether_glass" },
    weight = 3,
    layout = {
        fill_terrain = "t_nether_glass_floor",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "perk_closetland_closet_area" },
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "         -----          ",
            "         -...-          ",
            "         -.O.+          ",
            "         -...-          ",
            "         -----          ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        fill_terrain = "t_open_air",
        terrain = {
            O = "t_closetland_floor_olight",
            ["."] = "t_closetland_floor",
            ["-"] = "t_closetland_wall_wood",
            ["+"] = "t_closetland_door",
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "perk_closetland_closet_area_roof" },
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "         -----          ",
            "         -----          ",
            "         -----          ",
            "         -----          ",
            "         -----          ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        fill_terrain = "t_open_air",
        terrain = {
            O = "t_closetland_wood_roof",
            ["."] = "t_closetland_wood_roof",
            ["-"] = "t_closetland_wood_roof",
        },
    },
}

ccb.content.define_overmap_terrain {
    id = "closetland_nether_glass",
    name = ccb.content.text("Endless crystal"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "perk_closetland_closet_area",
    name = ccb.content.text("Closetland"),
    symbol = "C",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "perk_closetland_closet_area_roof",
    name = ccb.content.text("The roof"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}
