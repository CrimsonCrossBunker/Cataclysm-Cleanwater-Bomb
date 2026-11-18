local ccb = require("ccb")
local content = ccb.content

content.add(content.Recipe {
    id = "faction_wall_level_N_0",
    result = "faction_wall_level_N_0",
    description = ccb.content.text("A trench that may deter movement but is meant to be the foundation of a picket or palisade.  Requirements are for 1/2 an over map tile."),
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    skill = "fabrication",
    difficulty = 1,
    duration_moves = 3060000,
    activity_level = 4,
    autolearn = false,
    never_learn = true,
}:quality("DIG", 1, 1)
    :component("stick", 3))

content.add(content.Recipe {
    id = "faction_wall_level_N_1",
    result = "faction_wall_level_N_1",
    description = ccb.content.text("A deep trench filled with spikes, requires a trench.  Requirements are for 1/2 an over map tile."),
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    skill = "fabrication",
    difficulty = 2,
    duration_moves = 9180000,
    activity_level = 4,
    autolearn = false,
    never_learn = true,
}:quality("DIG", 2, 1)
    :component("pointy_stick", 68))
