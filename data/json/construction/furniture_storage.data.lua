local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_bookcase",
    group = "build_bookcase",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = {
        { { "2x4", 6 } },
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "nails", 16, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_bookcase",
}

ccb.content.define_construction {
    id = "constr_chest",
    group = "build_chest",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "80 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "wood_panel", 6 } }, { { "hinge", 2 } }, { { "nails", 10, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_chest",
}

ccb.content.define_construction {
    id = "constr_coffin_c",
    group = "seal_coffin",
    category = "FURN",
    required_skills = { { "mechanics", 0 } },
    duration = "10 m",
    using_requirements = { { "nails", 6 } },
    qualities = { { { id = "HAMMER", level = 1 } } },
    pre_terrain = "f_coffin_o",
    post_terrain = "f_coffin_c",
    post_flags = { "keep_items" },
}

ccb.content.define_construction {
    id = "constr_coffin_o",
    group = "build_coffin",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "2x4", 6 } },
        { { "wood_panel", 4 }, { "wood_sheet", 2 } },
        { { "sheet", 2 }, { "blanket", 1 }, { "down_blanket", 1 }, { "fur_blanket", 1 } },
        { { "nails", 24, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_coffin_o",
}

-- You can re-use the lid and most of the nails
ccb.content.define_construction {
    id = "constr_crate_c",
    group = "seal_crate",
    category = "FURN",
    required_skills = { { "mechanics", 0 } },
    duration = "10 m",
    using_requirements = { { "nails", 6 } },
    qualities = { { { id = "HAMMER", level = 1 } } },
    pre_terrain = "f_crate_o",
    post_flags = { "keep_items" },
    post_terrain = "f_crate_c",
}

ccb.content.define_construction {
    id = "constr_crate_o",
    group = "build_crate",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "45 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "wood_sheet", 2 }, { "wood_panel", 4 } },
        { { "2x4", 4 } },
        { { "nails", 24, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_crate_o",
}

ccb.content.define_construction {
    id = "constr_cupboard",
    group = "build_cupboard",
    category = "FURN",
    required_skills = { { "fabrication", 3 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "2x4", 3 } }, { { "wood_sheet", 1 }, { "wood_panel", 2 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_cupboard",
}

ccb.content.define_construction {
    id = "constr_dresser",
    group = "build_dresser",
    category = "FURN",
    required_skills = { { "fabrication", 3 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "wood_sheet", 1 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_dresser",
}

-- 1200cm of weld per rebar
ccb.content.define_construction {
    id = "constr_dumpster",
    group = "build_dumpster",
    category = "FURN",
    required_skills = { { "fabrication", 6 } },
    duration = "180 m",
    qualities = { { { id = "SAW_M", level = 1 } } },
    using_requirements = {
        { "welding_standard", 500 },
        { "welding_standard", 500 },
        { "welding_standard", 500 },
    },
    components = {
        { { "frame", 4 } },
        { { "sheet_metal", 16 } },
        { { "steel_lump_any", 2, "LIST" }, { "steel_chunk_any", 8, "LIST" }, { "scrap", 40 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_dumpster",
}

ccb.content.define_construction {
    id = "constr_entertainment_center",
    group = "build_entertainment_center",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "80 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = {
        { { "2x4", 14 } },
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "nails", 20, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_entertainment_center",
}

ccb.content.define_construction {
    id = "constr_locker",
    group = "build_locker",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "WRENCH", level = 1 } } },
    components = { { { "sheet_metal", 2 } }, { { "pipe", 8 } }, { { "lock", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_locker",
}

-- relatively small weld
ccb.content.define_construction {
    id = "constr_mailbox",
    group = "build_mailbox",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "60 m",
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "HAMMER", level = 2 } } },
    using_requirements = { { "welding_standard", 25 } },
    components = {
        { { "sheet_metal", 1 } },
        { { "wooden_post", 1 } },
        { { "2x4", 1 } },
        { { "nails", 5, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_mailbox",
}

-- wastebasket, no lid, 20 qt capacity, truncated rectangular pyramid base 10in×7.5in, top 11in×8.5in, height 13.5in
ccb.content.define_construction {
    id = "constr_metal_trashcan",
    group = "build_metal_trashcan",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 2 } } },
    components = { { { "sheet_metal", 1 } } },
    byproducts = { { item = "sheet_metal_small", count = 4 }, { item = "scrap", count = { 4, 6 } } },
    pre_checks = "check_empty",
    post_terrain = "f_metal_trashcan",
}

ccb.content.define_construction {
    id = "constr_rack",
    group = "build_metal_rack",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "WRENCH", level = 1 } } },
    components = { { { "pipe", 12 } }, { { "sheet_metal", 2 } } },
    pre_checks = "check_empty",
    post_terrain = "f_rack",
}

ccb.content.define_construction {
    id = "constr_rack_coat",
    group = "build_coat_rack",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "25 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 2 } }, { { "stick_long", 1 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_rack_coat",
}

ccb.content.define_construction {
    id = "constr_rack_wood",
    group = "build_wooden_rack",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "80 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = {
        { { "2x4", 6 } },
        { { "wood_sheet", 2 }, { "wood_panel", 4 } },
        { { "nails", 40, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_rack_wood",
}

ccb.content.define_construction {
    id = "constr_rack_primitive",
    group = "build_wooden_rack_primitive",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "240 m",
    qualities = { { { id = "CHISEL", level = 1 } }, { { id = "SAW_W", level = 1 } } },
    components = {
        { { "2x4", 6 } },
        { { "wood_sheet", 2 }, { "wood_panel", 4 } },
        { { "cordage_36_leather", 8 }, { "string_36", 8 }, { "cordage_36", 8 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_rack_primitive",
}

-- lots of 1 meter square metal sheet and plating so very big weld
ccb.content.define_construction {
    id = "constr_safe",
    group = "build_safe",
    category = "FURN",
    required_skills = { { "fabrication", 9 } },
    duration = "420 m",
    qualities = {
        { { id = "SAW_M", level = 1 } },
        { { id = "SCREW", level = 1 } },
        { { id = "SMOOTH", level = 2 } },
    },
    using_requirements = { { "welding_standard", 500 }, { "welding_standard", 500 } },
    tools = { { { "concrete_mix_tool", 50 } } },
    components = {
        { { "hdframe", 1 } },
        { { "steel_lump_any", 2, "LIST" }, { "steel_chunk_any", 8, "LIST" }, { "scrap", 40 } },
        { { "sheet_metal", 2 } },
        { { "rebar", 16 } },
        { { "concrete", 6 } },
        { { "water", 4 }, { "water_clean", 4 } },
        { { "cargo_lock", 1 } },
        { { "hard_plate", 1 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_safe_o",
}

ccb.content.define_construction {
    id = "constr_wardrobe",
    group = "build_wardrobe",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "60 m",
    qualities = {
        { { id = "HAMMER", level = 2 } },
        { { id = "SAW_W", level = 1 } },
        { { id = "SAW_M", level = 1 } },
    },
    components = {
        { { "2x4", 10 } },
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "nails", 24, "LIST" } },
        { { "pipe", 2 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_wardrobe",
}

ccb.content.define_construction {
    id = "constr_warehouse_shelf",
    group = "build_warehouse_shelf",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "WRENCH", level = 1 } } },
    components = { { { "pipe", 12 } }, { { "sheet_metal", 8 } } },
    pre_checks = "check_empty",
    post_terrain = "f_warehouse_shelf",
}
