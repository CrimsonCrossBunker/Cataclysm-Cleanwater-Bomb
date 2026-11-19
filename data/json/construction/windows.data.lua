local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_clean_broken_window",
    group = "clean_broken_window",
    category = "REPAIR",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    byproducts = { { item = "glass_shard", count = { 8, 16 } } },
    pre_terrain = "t_window_frame",
    post_terrain = "t_window_empty",
}

-- Step 1: Build double glazed glass window
ccb.content.define_construction {
    id = "constr_double_pane_glass",
    group = "build_double_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 3 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "glass_sheet", 2 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_double_pane_glass",
}

-- Step 2: Build curtain for double glazed glass window
ccb.content.define_construction {
    id = "constr_double_pane_glass_curtain",
    group = "build_double_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_double_pane_glass",
    post_terrain = "t_double_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_double_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_double_pane_glass",
    post_terrain = "t_double_pane_glass_taped",
}

-- Step 1 : metal frame
ccb.content.define_construction {
    id = "constr_m_frame",
    group = "build_reinforced_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 7 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "spike", 8 } }, { { "steel_chunk_any", 4, "LIST" }, { "scrap", 12 } } },
    pre_checks = "check_empty",
    post_terrain = "t_m_frame",
}

-- Step 1: Build metal grate over a window
ccb.content.define_construction {
    id = "constr_metal_grate_window",
    group = "build_metal_grate_over_a_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    tools = {
        {
            { "oxy_torch", 4 },
            { "welder", 20 },
            { "welding_kit", 20 },
            { "welder_crude", 30 },
            { "toolset", 30 },
        },
    },
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "GLARE", level = 1 } } },
    components = { { { "pipe", 12 } }, { { "sheet_metal", 4 } } },
    pre_terrain = "t_window_reinforced",
    post_terrain = "t_metal_grate_window",
}

-- Step 3: Build curtain over metal grate
ccb.content.define_construction {
    id = "constr_metal_grate_window_curtain",
    group = "build_metal_grate_over_a_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_metal_grate_window",
    post_terrain = "t_metal_grate_window_with_curtain",
}

-- Step 4: Build curtain over metal grate
ccb.content.define_construction {
    id = "constr_metal_grate_window_curtain_no_glass",
    group = "build_metal_grate_over_a_window_without_glass",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_metal_grate_window_noglass",
    post_terrain = "t_metal_grate_window_with_curtain_noglass",
}

-- Step 2: Build metal grate over a window
ccb.content.define_construction {
    id = "constr_metal_grate_window_no_glass",
    group = "build_metal_grate_over_a_window_without_glass",
    category = "REINFORCE",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    tools = {
        {
            { "oxy_torch", 4 },
            { "welder", 20 },
            { "welding_kit", 20 },
            { "welder_crude", 30 },
            { "toolset", 30 },
        },
    },
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "GLARE", level = 1 } } },
    components = { { { "pipe", 12 } }, { { "sheet_metal", 4 } } },
    pre_terrain = "t_window_reinforced_noglass",
    post_terrain = "t_metal_grate_window_noglass",
}

-- Step 1: Build plastic window
ccb.content.define_construction {
    id = "constr_plastic_window",
    group = "build_plastic_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "rigid_plastic_sheet", 1 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_plastic_window",
}

-- Step 2: Build curtain for plastic window
ccb.content.define_construction {
    id = "constr_plastic_window_curtain",
    group = "build_plastic_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_plastic_window",
    post_terrain = "t_plastic_window_with_curtain",
}

-- Step 1: Build quadruple glazed glass window
ccb.content.define_construction {
    id = "constr_quadruple_pane_glass",
    group = "build_quadruple_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 3 } },
    duration = "180 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "glass_sheet", 4 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_quadruple_pane_glass",
}

-- Step 2: Build curtain for quadruple glazed glass window
ccb.content.define_construction {
    id = "constr_quadruple_pane_glass_curtain",
    group = "build_quadruple_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_quadruple_pane_glass",
    post_terrain = "t_quadruple_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_quadruple_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_quadruple_pane_glass",
    post_terrain = "t_quadruple_pane_glass_taped",
}

-- Step 1: Build reinforced double glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_double_pane_glass",
    group = "build_reinforced_double_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = {
        { { "glass_sheet", 1 } },
        { { "reinforced_glass_sheet", 1 } },
        { { "nails", 16, "LIST" } },
        { { "2x4", 4 } },
    },
    pre_terrain = "t_window_empty",
    post_terrain = "t_reinforced_double_pane_glass",
}

-- Step 2: Build curtain for reinforced double glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_double_pane_glass_curtain",
    group = "build_reinforced_double_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_reinforced_double_pane_glass",
    post_terrain = "t_reinforced_double_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_reinforced_double_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_reinforced_double_pane_glass",
    post_terrain = "t_reinforced_double_pane_glass_taped",
}

-- Step 2 : Reinforced Glass
ccb.content.define_construction {
    id = "constr_reinforced_glass",
    group = "build_reinforced_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 8 } },
    duration = "150 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "reinforced_glass_sheet", 1 } } },
    pre_terrain = "t_m_frame",
    post_terrain = "t_reinforced_glass",
}

-- Step 3 : Metal shutters
ccb.content.define_construction {
    id = "constr_reinforce_glass_shutter",
    group = "build_reinforced_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 8 } },
    duration = "150 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "steel_plate", 2 } } },
    pre_terrain = "t_reinforced_glass",
    post_terrain = "t_reinforced_glass_shutter",
}

-- Step 1: Build reinforced plastic window
ccb.content.define_construction {
    id = "constr_reinforced_plastic_window",
    group = "build_reinforced_plastic_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "rigid_plastic_sheet", 3 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_reinforced_plastic_window",
}

-- Step 2: Build curtain for reinforced plastic window
ccb.content.define_construction {
    id = "constr_reinforced_plastic_window_curtain",
    group = "build_reinforced_plastic_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_reinforced_plastic_window",
    post_terrain = "t_reinforced_plastic_window_with_curtain",
}

-- Step 1: Build reinforced quadruple glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_quadruple_pane_glass",
    group = "build_reinforced_quadruple_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "180 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = {
        { { "glass_sheet", 3 } },
        { { "reinforced_glass_sheet", 1 } },
        { { "nails", 16, "LIST" } },
        { { "2x4", 4 } },
    },
    pre_terrain = "t_window_empty",
    post_terrain = "t_reinforced_quadruple_pane_glass",
}

-- Step 2: Build curtain for reinforced quadruple glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_quadruple_pane_glass_curtain",
    group = "build_reinforced_quadruple_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_reinforced_quadruple_pane_glass",
    post_terrain = "t_reinforced_quadruple_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_reinforced_quadruple_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_reinforced_quadruple_pane_glass",
    post_terrain = "t_reinforced_quadruple_pane_glass_taped",
}

-- Step 1: Build reinforced single glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_single_pane_glass",
    group = "build_reinforced_single_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "reinforced_glass_sheet", 1 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_reinforced_single_pane_glass",
}

-- Step 2: Build curtain for reinforced single glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_single_pane_glass_curtain",
    group = "build_reinforced_single_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_reinforced_single_pane_glass",
    post_terrain = "t_reinforced_single_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_reinforced_single_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_reinforced_single_pane_glass",
    post_terrain = "t_reinforced_single_pane_glass_taped",
}

-- Step 1: Build reinforced triple glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_triple_pane_glass",
    group = "build_reinforced_triple_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "150 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = {
        { { "glass_sheet", 2 } },
        { { "reinforced_glass_sheet", 1 } },
        { { "nails", 16, "LIST" } },
        { { "2x4", 4 } },
    },
    pre_terrain = "t_window_empty",
    post_terrain = "t_reinforced_triple_pane_glass",
}

-- Step 2: Build curtain for reinforced triple glazed glass window
ccb.content.define_construction {
    id = "constr_reinforced_triple_pane_glass_curtain",
    group = "build_reinforced_triple_glazed_glass_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_reinforced_triple_pane_glass",
    post_terrain = "t_reinforced_triple_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_reinforced_triple_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_reinforced_triple_pane_glass",
    post_terrain = "t_reinforced_triple_pane_glass_taped",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_double_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_double_pane_glass_taped",
    post_terrain = "t_double_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_quadruple_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_quadruple_pane_glass_taped",
    post_terrain = "t_quadruple_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_reinforced_double_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_reinforced_double_pane_glass_taped",
    post_terrain = "t_reinforced_double_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_reinforced_quadruple_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_reinforced_quadruple_pane_glass_taped",
    post_terrain = "t_reinforced_quadruple_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_reinforced_single_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_reinforced_single_pane_glass_taped",
    post_terrain = "t_reinforced_single_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_reinforced_triple_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_reinforced_triple_pane_glass_taped",
    post_terrain = "t_reinforced_triple_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_single_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_single_pane_glass_taped",
    post_terrain = "t_single_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_triple_pane_glass_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_triple_pane_glass_taped",
    post_terrain = "t_triple_pane_glass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_window_alarm_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_window_alarm_taped",
    post_terrain = "t_window_alarm",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_window_no_curtains_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_window_no_curtains_taped",
    post_terrain = "t_window_no_curtains",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_window_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_window_taped",
    post_terrain = "t_window",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_revert_window_domestic_taped",
    group = "remove_tape_from_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "2 m",
    qualities = { { { id = "CUT", level = 1 } } },
    byproducts = { { item = "duct_tape", charges = { 15, 25 } } },
    pre_terrain = "t_window_domestic_taped",
    post_terrain = "t_window_domestic",
}

-- Step 1: Build single glazed glass window
ccb.content.define_construction {
    id = "constr_single_pane_glass",
    group = "build_single_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "glass_sheet", 1 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_single_pane_glass",
}

-- Step 2: Build curtain for single glazed glass window
ccb.content.define_construction {
    id = "constr_single_pane_glass_curtain",
    group = "build_single_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_single_pane_glass",
    post_terrain = "t_single_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_single_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_single_pane_glass",
    post_terrain = "t_single_pane_glass_taped",
}

-- Step 1: Build skylight frame flat roof
ccb.content.define_construction {
    id = "constr_skylight_frame",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_flat_roof",
    post_terrain = "t_skylight_frame",
}

-- Step 5: Build skylight frame metal roof
ccb.content.define_construction {
    id = "constr_skylight_frame_metal_roof",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_metal_flat_roof",
    post_terrain = "t_skylight_frame",
}

-- Step 7: Build skylight frame open air
ccb.content.define_construction {
    id = "constr_skylight_frame_open_air",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_open_air",
    post_terrain = "t_skylight_frame",
}

-- Step 8: Build skylight frame rock roof
ccb.content.define_construction {
    id = "constr_skylight_frame_Rock_Roof",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_rock_roof",
    post_terrain = "t_skylight_frame",
    tools = { { { "pickaxe_list", 1, "LIST" }, { "jackhammering_standard", 1, "LIST" } } },
}

-- Step 3: Build skylight frame shingle roof
ccb.content.define_construction {
    id = "constr_skylight_frame_shingle_roof",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_shingle_flat_roof",
    post_terrain = "t_skylight_frame",
}

-- Step 2: Build skylight frame tar roof
ccb.content.define_construction {
    id = "constr_skylight_frame_tar_roof",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_tar_flat_roof",
    post_terrain = "t_skylight_frame",
}

-- Step 4: Build skylight frame thatched roof
ccb.content.define_construction {
    id = "constr_skylight_frame_thatched_roof",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_thatch_roof",
    post_terrain = "t_skylight_frame",
}

-- Step 6: Build skylight frame tiled roof
ccb.content.define_construction {
    id = "constr_skylight_frame_tiled_roof",
    group = "build_sky_light_frame",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_tile_flat_roof",
    post_terrain = "t_skylight_frame",
}

-- Step 1: Build tempered window
ccb.content.define_construction {
    id = "constr_tempered_window",
    group = "build_window_from_tempered_glass",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "tempered_glass_sheet", 1 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_tempered_glass_window",
}

-- Step 2: Build curtain for tempered window
ccb.content.define_construction {
    id = "constr_tempered_window_curtain",
    group = "build_window_from_tempered_glass",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_tempered_glass_window",
    post_terrain = "t_tempered_glass_with_curtain",
}

-- Step 1: Build triple glazed glass window
ccb.content.define_construction {
    id = "constr_triple_pane_glass",
    group = "build_triple_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 3 } },
    duration = "150 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "glass_sheet", 3 } }, { { "nails", 16, "LIST" } }, { { "2x4", 4 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_triple_pane_glass",
}

-- Step 2: Build curtain for triple glazed glass window
ccb.content.define_construction {
    id = "constr_triple_pane_glass_curtain",
    group = "build_triple_glazed_glass_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 1 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_triple_pane_glass",
    post_terrain = "t_triple_pane_glass_with_curtain",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_triple_pane_glass_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_triple_pane_glass",
    post_terrain = "t_triple_pane_glass_taped",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_window_alarm_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_window_alarm",
    post_terrain = "t_window_alarm_taped",
}

-- 4cm weld per rebar + welding all the metal squares into place
ccb.content.define_construction {
    id = "constr_window_bars",
    group = "install_bars_onto_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "SCREW", level = 1 } } },
    using_requirements = { { "welding_standard", 250 } },
    components = { { { "rebar", 8 } }, { { "sheet_metal_small", 6 } } },
    pre_terrain = "t_window",
    post_terrain = "t_window_bars",
}

-- 4cm weld per rebar + welding all the metal squares into place
ccb.content.define_construction {
    id = "constr_window_bars_alarm",
    group = "install_bars_onto_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "SCREW", level = 1 } } },
    using_requirements = { { "welding_standard", 250 } },
    components = { { { "rebar", 8 } }, { { "sheet_metal_small", 6 } } },
    pre_terrain = "t_window_alarm",
    post_terrain = "t_window_bars_alarm",
}

ccb.content.define_construction {
    id = "constr_window_bars_curtains",
    group = "install_bars_onto_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "SAW_W", level = 1 } }, { { id = "HAMMER", level = 2 } } },
    components = { { { "nails", 4, "LIST" } }, { { "sheet", 2 } }, { { "stick", 1 } }, { { "string_36", 1 } } },
    pre_terrain = "t_window_bars",
    post_terrain = "t_window_bars_curtains",
}

-- 4cm weld per rebar + welding all the metal squares into place
ccb.content.define_construction {
    id = "constr_window_bars_frame",
    group = "install_bars_onto_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "SCREW", level = 1 } } },
    using_requirements = { { "welding_standard", 250 } },
    components = { { { "rebar", 8 } }, { { "sheet_metal_small", 6 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_window_bars_noglass",
}

-- 4cm weld per rebar + welding all the metal squares into place
ccb.content.define_construction {
    id = "constr_window_bars_no_curtains",
    group = "install_bars_onto_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "SCREW", level = 1 } } },
    using_requirements = { { "welding_standard", 250 } },
    components = { { { "rebar", 8 } }, { { "sheet_metal_small", 6 } } },
    pre_terrain = "t_window_no_curtains",
    post_terrain = "t_window_bars",
}

-- Board up normal window
ccb.content.define_construction {
    id = "constr_window_boarded",
    group = "board_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 } }, { { "nails", 8, "LIST" } } },
    pre_flags = "BARRICADABLE_WINDOW",
    post_terrain = "t_window_boarded",
}

-- Bolt sturdy wood shutters onto a window
ccb.content.define_construction {
    id = "constr_window_boarded_shutters",
    group = "wooden_shutters",
    category = "REINFORCE",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = {
        {
            { id = "HAMMER", level = 2 },
            { id = "WRENCH", level = 1 },
            { id = "DRILL", level = 1 },
            { id = "SAW_W", level = 2 },
        },
    },
    components = {
        { { "2x4", 7 } },
        { { "wood_panel", 4 } },
        { { "hinge", 4 } },
        { { "nuts_bolts", 8 } },
        { { "nails", 16, "LIST" } },
    },
    pre_flags = "BARRICADABLE_WINDOW",
    post_terrain = "t_window_boarded_shutters_closed",
}

-- Board up window with curtains
ccb.content.define_construction {
    id = "constr_window_boarded_curtains",
    group = "board_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 } }, { { "nails", 8, "LIST" } } },
    pre_flags = "BARRICADABLE_WINDOW_CURTAINS",
    post_terrain = "t_window_boarded",
    completion_actions = "done_window_curtains",
}

-- Board up empty window
ccb.content.define_construction {
    id = "constr_window_boarded_noglass_empty",
    group = "board_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 } }, { { "nails", 8, "LIST" } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_window_boarded_noglass",
}

-- Board up window frame only
ccb.content.define_construction {
    id = "constr_window_boarded_noglass_frame",
    group = "board_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 } }, { { "nails", 8, "LIST" } } },
    pre_terrain = "t_window_frame",
    post_terrain = "t_window_boarded_noglass",
}

-- Step 3: window with curtains
ccb.content.define_construction {
    id = "constr_window_domestic",
    group = "build_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "SAW_W", level = 1 } }, { { id = "HAMMER", level = 2 } } },
    components = {
        { { "nails", 4, "LIST" } },
        { { "sheet", 2 } },
        { { "stick", 1 } },
        { { "string_36", 1 }, { "cordage_36", 1 } },
    },
    pre_terrain = "t_window_no_curtains",
    post_terrain = "t_window_domestic",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_window_domestic_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_window_domestic",
    post_terrain = "t_window_domestic_taped",
}

-- Step 1: window frame
ccb.content.define_construction {
    id = "constr_window_empty",
    group = "build_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "75 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 15 }, { "log", 2 } }, { { "nails", 30, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "t_window_empty",
}

-- Armor up regular reinforced window
ccb.content.define_construction {
    id = "constr_window_enhanced",
    group = "armor_reinforced_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 6 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "spike", 4 } }, { { "steel_plate", 1 }, { "sheet_metal", 4 } } },
    pre_terrain = "t_window_reinforced",
    post_terrain = "t_window_enhanced",
}

-- When underlying window has no glass
ccb.content.define_construction {
    id = "constr_window_enhanced_noglass",
    group = "armor_reinforced_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 6 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "spike", 4 } }, { { "steel_plate", 1 }, { "sheet_metal", 4 } } },
    pre_terrain = "t_window_reinforced_noglass",
    post_terrain = "t_window_enhanced_noglass",
}

-- Step 2: window, no curtains
ccb.content.define_construction {
    id = "constr_window_no_curtains",
    group = "build_window",
    category = "WINDOWS",
    required_skills = { { "fabrication", 3 } },
    duration = "30 m",
    components = { { { "glass_sheet", 1 } } },
    pre_terrain = "t_window_empty",
    post_terrain = "t_window_no_curtains",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_window_no_curtains_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_window_no_curtains",
    post_terrain = "t_window_no_curtains_taped",
}

-- For regular windows
ccb.content.define_construction {
    id = "constr_window_reinforced",
    group = "reinforce_boarded_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 8 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_window_boarded",
    post_terrain = "t_window_reinforced",
}

-- For windows with no glass that were barricaded
ccb.content.define_construction {
    id = "constr_window_reinforced_noglass",
    group = "reinforce_boarded_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 8 } }, { { "nails", 16, "LIST" } } },
    pre_terrain = "t_window_boarded_noglass",
    post_terrain = "t_window_reinforced_noglass",
}

-- Need a recipe for each type of window tapable due to how code works
ccb.content.define_construction {
    id = "constr_window_taped",
    group = "tape_up_window",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "duct_tape", 50 } } },
    pre_terrain = "t_window",
    post_terrain = "t_window_taped",
}

-- Installs curtains on Empty window
ccb.content.define_construction {
    id = "constr_window_empty_curtain",
    group = "cover_windowframe_with_sheet",
    category = "WINDOWS",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "SAW_W", level = 1 } }, { { id = "HAMMER", level = 2 } } },
    components = {
        { { "nails", 4, "LIST" } },
        { { "sheet", 2 } },
        { { "stick", 1 } },
        { { "string_36", 1 }, { "cordage_36", 1 } },
    },
    pre_terrain = "t_window_empty",
    post_terrain = "t_window_empty_curtains_closed",
}

ccb.content.define_construction {
    id = "constr_window_bars_add_glass",
    group = "install_glass_onto_window_bars",
    category = "WINDOWS",
    required_skills = { { "fabrication", 5 } },
    duration = "30 m",
    components = { { { "glass_sheet", 1 } } },
    pre_terrain = "t_window_bars_noglass",
    post_terrain = "t_window_bars",
}

ccb.content.define_construction {
    id = "constr_window_galass_bars_add_curtains",
    group = "install_glass_onto_window_bars",
    category = "WINDOWS",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "SAW_W", level = 1 } }, { { id = "HAMMER", level = 2 } } },
    components = {
        { { "nails", 4, "LIST" } },
        { { "sheet", 2 } },
        { { "stick", 1 } },
        { { "string_36", 1 }, { "cordage_36", 1 } },
    },
    pre_terrain = "t_window_bars",
    post_terrain = "t_window_bars_curtains",
}
