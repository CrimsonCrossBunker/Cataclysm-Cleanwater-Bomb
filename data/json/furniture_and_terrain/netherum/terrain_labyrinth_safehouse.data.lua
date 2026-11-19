local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_utility_space",
    name = ccb.content.text("Metal stele"),
    description = ccb.content.text("A floor to ceiling, shining column.  A massive face with a gaping jaw is cast upon it.  Inside the mouth are several pre-fabricated slots."),
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_utility_space",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_living_space_1",
    name = ccb.content.text("Metal stele"),
    description = ccb.content.text("A floor to ceiling, shining column.  A massive face with a gaping jaw is cast upon it.  Inside the mouth are several pre-fabricated slots."),
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_living_space_1",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_autodoc",
    name = ccb.content.text("Metal stele"),
    description = ccb.content.text("A floor to ceiling, shining column.  A massive face with a gaping jaw is cast upon it.  Inside the mouth are several pre-fabricated slots."),
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_autodoc",
}
