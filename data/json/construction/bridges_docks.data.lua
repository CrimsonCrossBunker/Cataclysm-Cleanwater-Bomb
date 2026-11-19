local ccb = require("ccb")

-- Set up dock
ccb.content.define_construction {
    id = "constr_dock",
    group = "build_river_dock_shallow_bridge",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "2x4", 6 } }, { { "log", 1 } }, { { "nails", 12, "LIST" } } },
    pre_terrain = "t_water_sh",
    post_terrain = "t_dock",
}

-- Step 3: Finish with a wood surface
ccb.content.define_construction {
    id = "constr_dock_deep",
    group = "build_deep_river_dock",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "2x4", 14 } }, { { "nails", 28, "LIST" } } },
    pre_terrain = "t_dock_deep_frame",
    post_terrain = "t_dock_deep",
}

-- Step 2: add a log frame atop the pile
ccb.content.define_construction {
    id = "constr_dock_deep_frame",
    group = "build_deep_river_dock",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "log", 4 } }, { { "spike", 8 } } },
    pre_terrain = "t_dock_deep_pile",
    post_terrain = "t_dock_deep_frame",
}

-- Step 1: securing a pile down on the lakebed; not easy work without machinery
ccb.content.define_construction {
    id = "constr_dock_deep_pile",
    group = "build_deep_river_dock",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 } },
    duration = "720 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "DIG", level = 2 } } },
    components = { { { "wood_beam", 1 } }, { { "spike", 4 } } },
    pre_terrain = "t_water_dp",
    post_terrain = "t_dock_deep_pile",
}

-- Step 1: securing a pile down on the riverbed; not easy work without machinery
ccb.content.define_construction {
    id = "constr_dock_deep_pile_moving",
    group = "build_deep_river_dock",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 } },
    duration = "720 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "DIG", level = 2 } } },
    components = { { { "wood_beam", 1 } }, { { "spike", 4 } } },
    pre_terrain = "t_water_moving_dp",
    post_terrain = "t_dock_deep_pile",
}

-- Set up dock
ccb.content.define_construction {
    id = "constr_dock_moving",
    group = "build_river_dock_shallow_bridge",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "2x4", 6 } }, { { "log", 1 } }, { { "nails", 12, "LIST" } } },
    pre_terrain = "t_water_moving_sh",
    post_terrain = "t_dock",
}

-- Set up pontoon bridge
ccb.content.define_construction {
    id = "constr_pontoon_dp",
    group = "build_pontoon_bridge",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "2x4", 4 } },
        { { "2x4", 4 }, { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "rope_natural", 1, "LIST" } },
        { { "55gal_drum", 2 }, { "30gal_drum", 2 }, { "wooden_barrel", 2 } },
    },
    pre_terrain = "t_water_dp",
    post_terrain = "t_pontoon_dp",
}

-- Set up River bridge
ccb.content.define_construction {
    id = "constr_riverbridge_dp",
    group = "build_river_bridge",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "2x4", 4 } },
        { { "2x4", 4 }, { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "rope_natural", 1, "LIST" } },
        { { "55gal_drum", 2 }, { "30gal_drum", 2 }, { "wooden_barrel", 2 } },
    },
    pre_terrain = "t_water_moving_dp",
    post_terrain = "t_riverbridge_dp",
}

-- Set up shallow bridge
ccb.content.define_construction {
    id = "constr_sh_bridge",
    group = "build_shallow_temporary_bridge",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "2x4", 6 } }, { { "log", 1 } }, { { "nails", 12, "LIST" } } },
    pre_terrain = "t_water_sh",
    post_terrain = "t_sh_bridge",
}
