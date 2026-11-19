local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    name = ccb.content.text("labyrinthian structures"),
    id = "labyrinth_hall",
    symbol = "_",
    color = "light_blue",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("bosky labyrinth"),
    id = "labyrinth_overgrown_hall",
    color = "light_green",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("terminal"),
    id = "labyrinth_entrance",
    symbol = "O",
    color = "red",
    see_cost = "high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("root"),
    id = "labyrinth_overgrown_entrance",
    symbol = "O",
    color = "light_red",
    see_cost = "high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("sparkling chasm"),
    id = "netherum_labyrinth_sparkling_chasm",
    symbol = "*",
    color = "dark_gray",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("home away from home"),
    id = "labyrinth_safehouse",
    symbol = "@",
    color = "white",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("central node"),
    id = "labyrinth_nl_exit_boiler",
    symbol = "O",
    color = "red",
    see_cost = "high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("flattened landscape"),
    id = {
        "labyrinth_string_dimension_tunnel_start", "labyrinth_string_dimension_tunnel_end",
        "labyrinth_string_dimension_tunnel_left", "labyrinth_string_dimension_tunnel_right",
        "labyrinth_string_dimension_tunnel_over", "labyrinth_string_dimension_tunnel_under",
        "labyrinth_string_dimension_tunnel_portal",
    },
    symbol = "-",
    color = "light_blue",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("terminal"),
    id = "labyrinth_flooded_entrance",
    symbol = "O",
    color = "cyan",
    see_cost = "high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("labyrinthian gangways"),
    id = "labyrinth_flooded_hall",
    symbol = "_",
    color = "light_blue",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("labyrinthian hallways"),
    id = "labyrinth2",
    symbol = "+",
    color = "light_gray",
    see_cost = "high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("labyrinthian structure"),
    id = {
        "labyrinth2_scarlet_sea_portal_x0_y0", "labyrinth2_scarlet_sea_portal_x1_y0",
        "labyrinth2_scarlet_sea_portal_x0_y1", "labyrinth2_scarlet_sea_portal_x1_y1",
    },
    symbol = "+",
    color = "light_red",
    see_cost = "high",
    travel_cost = "impassable",
    flags = { "NO_ROTATE" },
}
