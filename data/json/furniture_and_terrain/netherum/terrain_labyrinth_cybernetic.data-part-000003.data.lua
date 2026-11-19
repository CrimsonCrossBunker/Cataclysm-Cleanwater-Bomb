local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_stairs_up",
    looks_like = "t_stairs_up",
    name = ccb.content.text("mysterious stairs"),
    description = ccb.content.text("A tightly wound spiral staircase vanishing into the depths above."),
    symbol = "<",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_UP", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_nl_stairs_up_false",
    looks_like = "t_nl_stairs_up",
    name = ccb.content.text("mysterious stairs"),
    description = ccb.content.text("A tightly wound spiral staircase going up.  However, it stops at the ceiling, perfectly flush with it, as if it were supposed to go up, but couldn't."),
    symbol = "<",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_nl_stairs_down",
    looks_like = "t_stairs_down",
    name = ccb.content.text("mysterious stairs"),
    description = ccb.content.text("A tightly wound spiral staircase vanishing into the depths below."),
    symbol = ">",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_DOWN", "INDOORS", "PLACE_ITEM" },
}
