local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_beaded_door",
    group = "build_beaded_curtain",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "wooden_bead", 2000 } }, { { "stick_long", 1 } }, { { "string_36", 20 } } },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_terrain = "t_door_frame",
    post_terrain = "f_beaded_door",
}

-- Step 2: door
ccb.content.define_construction {
    id = "constr_door",
    group = "build_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "2x4", 2 } }, { { "wood_panel", 1 } }, { { "nails", 12, "LIST" } }, { { "hinge", 2 } } },
    pre_terrain = "t_door_frame",
    post_terrain = "t_door_c",
}

-- step 2: Bar Door
-- 4cm weld per rebar + welding all the metal squares into place
ccb.content.define_construction {
    id = "constr_door_bar",
    group = "build_bar_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 } },
    duration = "180 m",
    qualities = {
        { { id = "SAW_M", level = 1 } },
        { { id = "SCREW", level = 1 } },
        { { id = "WRENCH", level = 1 } },
    },
    using_requirements = { { "welding_standard", 500 } },
    components = {
        { { "rebar", 16 } },
        { { "sheet_metal_small", 12 } },
        { { "hinge", 2 } },
        { { "nuts_bolts", 8 } },
    },
    pre_terrain = "t_mdoor_frame",
    post_terrain = "t_door_bar_c",
}

-- regular door
ccb.content.define_construction {
    id = "constr_door_boarded",
    group = "board_up_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_flags = "BARRICADABLE_DOOR",
    post_terrain = "t_door_boarded",
}

-- boarded damaged door
ccb.content.define_construction {
    id = "constr_door_boarded_damaged",
    group = "board_up_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_flags = "BARRICADABLE_DOOR_DAMAGED",
    post_terrain = "t_door_boarded_damaged",
}

-- boarded damaged peephole door
ccb.content.define_construction {
    id = "constr_door_boarded_damaged_peep",
    group = "board_up_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_terrain = "t_door_b_peep",
    post_terrain = "t_door_boarded_damaged_peep",
}

-- peephole door
ccb.content.define_construction {
    id = "constr_door_boarded_peep",
    group = "board_up_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_terrain = "t_door_c_peep",
    post_terrain = "t_door_boarded_peep",
}

-- Door frame not required
ccb.content.define_construction {
    id = "constr_door_curtain",
    group = "build_door_curtain",
    category = "CONSTRUCT",
    required_skills = { { "tailor", 1 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = {
        { { "nails", 4, "LIST" }, { "pointy_stick", 2 }, { "spike", 2 } },
        { { "sheet", 2 } },
        { { "stick", 1 } },
        { { "withered", 12 }, { "straw_pile", 12 }, { "string_36", 1 } },
    },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_checks = "check_empty",
    post_terrain = "t_door_curtain_c",
}

-- Step 1: door frame
ccb.content.define_construction {
    id = "constr_door_frame",
    group = "build_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 12 } }, { { "nails", 24, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "t_door_frame",
}

-- Door frame not required
ccb.content.define_construction {
    id = "constr_door_grass_curtain",
    group = "build_door_grass_curtain",
    category = "CONSTRUCT",
    required_skills = { { "tailor", 1 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = {
        { { "nails", 4, "LIST" }, { "pointy_stick", 2 }, { "spike", 2 } },
        { { "grass_sheet", 2 } },
        { { "stick", 1 } },
        { { "string_36", 1 }, { "cordage_36", 1 }, { "string_6", 6 }, { "cordage_6", 6 } },
    },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_checks = "check_empty",
    post_terrain = "t_door_grass_curtain_c",
}

-- Step 2: Makeshift Door
ccb.content.define_construction {
    id = "constr_door_makeshift",
    group = "build_makeshift_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "CUT", level = 2 } } },
    components = {
        { { "2x4", 6 }, { "stick", 6 }, { "stick_long", 3 }, { "wood_panel", 1 } },
        { { "rope_natural_short", 1, "LIST" } },
    },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_terrain = "t_door_frame",
    post_terrain = "t_door_makeshift_c",
}

-- Step 2: metal door
ccb.content.define_construction {
    id = "constr_door_metal",
    group = "build_metal_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 7 } },
    duration = "120 m",
    qualities = {
        { { id = "HAMMER", level = 2 } },
        { { id = "SAW_M", level = 1 } },
        { { id = "WRENCH", level = 1 } },
    },
    components = {
        { { "steel_lump_any", 4, "LIST" }, { "steel_chunk_any", 12, "LIST" }, { "scrap", 36 } },
        { { "steel_plate", 2 }, { "sheet_metal", 8 } },
        { { "hinge", 3 } },
    },
    pre_terrain = "t_mdoor_frame",
    post_terrain = "t_door_metal_c",
}

-- Step 3: peephole
ccb.content.define_construction {
    id = "constr_door_metal_peep",
    group = "build_metal_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "25 m",
    qualities = {
        { { id = "DRILL", level = 1 } },
        { { id = "SCREW", level = 1 } },
        { { id = "WRENCH", level = 1 } },
    },
    components = { { { "peephole", 1 } } },
    pre_terrain = "t_door_metal_c",
    post_terrain = "t_door_metal_c_peep",
}

-- Step 3: peephole
ccb.content.define_construction {
    id = "constr_door_peep",
    group = "build_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "15 m",
    qualities = {
        { { id = "DRILL", level = 1 } },
        { { id = "SCREW", level = 1 } },
        { { id = "WRENCH", level = 1 } },
    },
    components = { { { "peephole", 1 } } },
    pre_terrain = "t_door_c",
    post_terrain = "t_door_c_peep",
}

ccb.content.define_construction {
    id = "constr_glass_wall_door",
    group = "build_glass_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER_SOFT", level = 1 } } },
    components = {
        { { "frame_wood", 1 } },
        { { "chunk_rubber", 16 } },
        { { "glass_sheet", 2 } },
        { { "cotton_patchwork", 8 } },
    },
    pre_note = ccb.content.text("Must be supported on at least two sides."),
    pre_checks = "check_support",
    post_terrain = "t_door_glass_c",
}

-- step 1: door frame
ccb.content.define_construction {
    id = "constr_mbdoor_frame",
    group = "build_bar_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "spike", 8 } }, { { "steel_chunk_any", 4, "LIST" }, { "scrap", 12 } } },
    pre_checks = "check_empty",
    post_terrain = "t_mdoor_frame",
}

-- step 1: door frame
ccb.content.define_construction {
    id = "constr_mdoor_frame",
    group = "build_metal_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "spike", 8 } }, { { "steel_chunk_any", 4, "LIST" }, { "scrap", 12 } } },
    pre_checks = "check_empty",
    post_terrain = "t_mdoor_frame",
}

ccb.content.define_construction {
    id = "constr_metal_gate",
    group = "build_metal_gate",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 }, { "mechanics", 4 } },
    duration = "120 m",
    tools = {
        {
            { "oxy_torch", 10 },
            { "welder", 50 },
            { "welding_kit", 50 },
            { "welder_crude", 75 },
            { "toolset", 75 },
        },
    },
    qualities = { { { id = "SAW_M", level = 2 } }, { { id = "GLARE", level = 1 } } },
    components = {
        { { "steel_lump_any", 8, "LIST" }, { "steel_chunk_any", 24, "LIST" }, { "scrap", 72 } },
        { { "sheet_metal", 16 } },
        { { "frame", 4 }, { "spike", 24 } },
    },
    pre_note = ccb.content.text("Must be between ordinary, concrete, brick, or rock walls to function, and at least one wall must have an adjacent mechanical winch."),
    pre_checks = "check_empty",
    post_terrain = "t_door_metal_locked",
}

ccb.content.define_construction {
    id = "constr_rdoor",
    group = "reinforce_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 3 } },
    duration = "45 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "2x4", 6 }, { "wood_panel", 1 } },
        { { "2x4", 6 } },
        { { "nails", 48, "LIST" } },
        { { "hinge", 1 } },
    },
    pre_flags = "BARRICADABLE_DOOR",
    post_terrain = "t_rdoor_c",
}

-- the reinforced doors
ccb.content.define_construction {
    id = "constr_rdoor_boarded",
    group = "board_up_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_flags = "BARRICADABLE_DOOR_REINFORCED",
    post_terrain = "t_rdoor_boarded",
}

-- damaged reinforced doors
ccb.content.define_construction {
    id = "constr_rdoor_boarded_damaged",
    group = "board_up_wood_door",
    category = "REINFORCE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_flags = "BARRICADABLE_DOOR_REINFORCED_DAMAGED",
    post_terrain = "t_rdoor_boarded_damaged",
}

-- Repair the regular door
ccb.content.define_construction {
    id = "constr_repair_door",
    group = "repair_wood_door",
    category = "REPAIR",
    required_skills = { { "fabrication", 1 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 3 }, { "wood_panel", 1 } }, { { "nails", 12, "LIST" } } },
    pre_terrain = "t_door_b",
    post_terrain = "t_door_c",
}

-- Repair the peephole door
ccb.content.define_construction {
    id = "constr_repair_door_peep",
    group = "repair_wood_door",
    category = "REPAIR",
    required_skills = { { "fabrication", 1 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 3 }, { "wood_panel", 1 } }, { { "nails", 12, "LIST" } } },
    pre_terrain = "t_door_b_peep",
    post_terrain = "t_door_c_peep",
}

-- Repair the reinforced door
ccb.content.define_construction {
    id = "constr_repair_rdoor",
    group = "repair_wood_door",
    category = "REPAIR",
    required_skills = { { "fabrication", 2 } },
    duration = "45 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 6 }, { "wood_panel", 1 } }, { { "nails", 24, "LIST" } } },
    pre_terrain = "t_rdoor_b",
    post_terrain = "t_rdoor_c",
}

-- Step 1: door frame
ccb.content.define_construction {
    id = "constr_sdoor_frame",
    group = "build_makeshift_door",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 12 } }, { { "nails", 24, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "t_door_frame",
}
