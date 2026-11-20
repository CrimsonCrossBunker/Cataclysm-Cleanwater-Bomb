local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_infinite_shaft_rooved",
    name = ccb.content.text("open air"),
    description = ccb.content.text("An area of open air in what appears to be a shaft extending into the depths of the earth.  You cannot understand how or why someone would build an elevator shaft going into the depths of the earth like this for reasons other than mining.  It's bottom, if there is one, seems to be far past where light penetrates."),
    symbol = " ",
    color = "i_cyan",
    move_cost = 2,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "TRANSPARENT_FLOOR", "GOES_DOWN", "INDOORS", "FREE_TO_EXAMINE" },
    examine_handler = "examine_lixa_elevator_ledge",
}
