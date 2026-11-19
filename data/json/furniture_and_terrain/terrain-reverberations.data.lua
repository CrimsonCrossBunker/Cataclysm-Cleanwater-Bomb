local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_inner_cabins_door_o",
    name = ccb.content.text("strange open door"),
    description = ccb.content.text("A wide open door swinging outward, into the darkness, beyond your reach.  The door and the frame look fresh, as if installed recently."),
    symbol = "'",
    color = "brown",
    looks_like = "t_door_o",
    move_cost = 2,
    roof = "t_wood_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "SUPPORTS_ROOF" },
}

ccb.content.define_terrain {
    id = "t_inner_cabins_nether_glass_floor",
    name = ccb.content.text("black glass"),
    description = ccb.content.text("An endless expanse of black glass, illuminated by dim, otherworldly light."),
    symbol = " ",
    color = "black",
    move_cost = 2,
    light_emitted = 5,
    light_color = { 150, 75, 0 },
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}
