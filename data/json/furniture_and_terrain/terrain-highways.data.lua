local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_pavement_hw_air",
    name = ccb.content.text("bridge pavement"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("A bridge section made out of concrete and metal."),
    looks_like = "t_pavement",
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 300,
        sound = ccb.content.text("concrete cracking and metal screeching!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 4, 20 } }, { item = "rebar", count = { 10, 20 } } },
    },
}

ccb.content.define_terrain {
    id = "t_pavement_y_hw_air",
    name = ccb.content.text("bridge yellow pavement"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("A bridge section made out of concrete and metal.  It's painted yellow."),
    looks_like = "t_pavement_y",
    symbol = ".",
    color = "yellow",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 300,
        sound = ccb.content.text("concrete cracking and metal screeching!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 4, 20 } }, { item = "rebar", count = { 10, 20 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sidewalk_hw_air",
    name = ccb.content.text("bridge sidewalk"),
    description = ccb.content.text("The sidewalk section of a concrete bridge."),
    looks_like = "t_sidewalk",
    symbol = ".",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 300,
        sound = ccb.content.text("concrete cracking and metal screeching!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 4, 20 } }, { item = "rebar", count = { 10, 20 } } },
    },
}
