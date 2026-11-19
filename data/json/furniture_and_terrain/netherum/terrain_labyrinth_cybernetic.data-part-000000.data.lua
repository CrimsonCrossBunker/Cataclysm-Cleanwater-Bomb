local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk0"),
    description = ccb.content.text("Obelisk"),
    looks_like = "f_machinery_old",
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_0",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_1",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk1"),
    description = ccb.content.text("Obelisk"),
    symbol = "A",
    color = "blue",
    examine_handler = "examine_t_nl_obelisk_1",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_2",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk2"),
    description = ccb.content.text("Obelisk"),
    symbol = "A",
    color = "yellow",
    examine_handler = "examine_t_nl_obelisk_2",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_3",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk3"),
    description = ccb.content.text("Obelisk"),
    symbol = "A",
    color = "red",
    examine_handler = "examine_t_nl_obelisk_3",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_boiler",
    name = ccb.content.text("Obelisk"),
    description = ccb.content.text("A tall, drab grey, metallic pillar covered in swirling patterns.  You could Examine it closer to try and discern the shapes."),
    looks_like = "f_machinery_old",
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_boiler",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_water_cooler",
    name = ccb.content.text("Obelisk"),
    description = ccb.content.text("A tall, cerulean-blue, metallic pillar covered in swirling patterns.  You could Examine it closer to try and discern the shapes."),
    symbol = "A",
    color = "cyan",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_water_cooler",
}

ccb.content.define_terrain {
    id = "t_nl_mission_water_cooler",
    name = ccb.content.text("bulbous water tank"),
    description = ccb.content.text("This would almost look like an earthly water cooler, except the base is made up of cobbled together scrap metal, and the tank is a clouded fishbowl of green liquid.  Where the tap would be is a very thin, sharp spike, which feeds a dribble-tube that might flow into the tank itself."),
    symbol = "W",
    color = "blue",
    looks_like = "f_water_purifier",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_mission_water_cooler",
}
