local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "augustmoon_outer_space" },
    name = ccb.content.text("Port Augustmoon's orbit"),
    symbol = " ",
    color = "black",
    see_cost = "all_clear",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "augustmoon_main_concourse1", "augustmoon_main_concourse2" },
    name = ccb.content.text("Port Augustmoon"),
    symbol = "+",
    color = "red",
    see_cost = "high",
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = {
        "augustmoon_corpo_quarter1", "augustmoon_corpo_quarter2", "augustmoon_corpo_quarter3",
        "augustmoon_corpo_quarter4",
    },
    name = ccb.content.text("Corporate Spire"),
    symbol = "+",
    color = "red",
    see_cost = "high",
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "augustmoon_docking_arm",
    name = ccb.content.text("Docking Arm Strbd.  2"),
    symbol = "i",
    color = "red",
    see_cost = "high",
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "augustmoon_bar",
    name = ccb.content.text("Artificial Feel"),
    symbol = "-",
    color = "red",
    see_cost = "high",
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "augustmoon_solar_array1", "augustmoon_solar_array2" },
    name = ccb.content.text("solar array"),
    symbol = "+",
    color = "red",
    see_cost = "low",
}
