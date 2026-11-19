local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_earthen_stairs_up",
    name = ccb.content.text("earthen stairs"),
    description = ccb.content.text("A set of stone and dirt steps leading up."),
    symbol = "<",
    color = "dark_gray",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_UP", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_earthen_stairs_down",
    name = ccb.content.text("earthen stairs"),
    description = ccb.content.text("A set of stone and dirt steps leading down."),
    symbol = ">",
    color = "dark_gray",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "GOES_DOWN", "INDOORS", "PLACE_ITEM", "SUPPORTS_ROOF" },
}
