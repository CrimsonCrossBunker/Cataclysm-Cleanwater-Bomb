local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_adobe_brick_wall_embrasure",
    group = "build_brick_wall_embrasure_from_adobe",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "120 m",
    qualities = { { { id = "SMOOTH", level = 1 } } },
    components = {
        { { "adobe_brick", 10 } },
        { { "mortar_adobe", 1 } },
        { { "water", 1 }, { "water_clean", 1 } },
        { { "material_sand", 20 } },
    },
    pre_terrain = "t_adobe_brick_wall_halfway",
    post_terrain = "t_embrasure_adobe_brick",
}

-- Remove some bricks from a full wall to create an opening
ccb.content.define_construction {
    id = "constr_adobe_brick_wall_embrasure_removebricks",
    group = "build_brick_wall_embrasure_from_adobe",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "30 m",
    tools = { { { "pickaxe_list", 1, "LIST" }, { "jackhammering_standard", 1, "LIST" } } },
    pre_terrain = "t_adobe_brick_wall",
    post_terrain = "t_embrasure_adobe_brick",
}

ccb.content.define_construction {
    id = "constr_brick_wall_embrasure",
    group = "build_brick_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "120 m",
    qualities = { { { id = "SMOOTH", level = 1 } } },
    components = {
        { { "brick", 15 } },
        { { "mortar_build", 1 }, { "mortar_lime", 1 } },
        { { "water", 1 }, { "water_clean", 1 } },
    },
    pre_terrain = "t_brick_wall_halfway",
    post_terrain = "t_embrasure_brick",
}

-- Remove some bricks from a full wall to create an opening
ccb.content.define_construction {
    id = "constr_brick_wall_embrasure_removebricks",
    group = "build_brick_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "30 m",
    tools = { { { "pickaxe_list", 1, "LIST" }, { "jackhammering_standard", 1, "LIST" } } },
    pre_terrain = "t_brick_wall",
    post_terrain = "t_embrasure_brick",
}

ccb.content.define_construction {
    id = "constr_palisade_embrasure",
    group = "build_palisade_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 }, { "survival", 2 } },
    duration = "120 m",
    qualities = { { { id = "DIG", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "log", 3 } },
        {
            { "lc_wire", 6 },
            { "wire_barbed", 4 },
            { "rope_6", 2 },
            { "rope_natural_short", 2, "LIST" },
            { "chain", 1 },
            { "vine_30", 1 },
        },
    },
    pre_terrain = "t_pit",
    post_terrain = "t_palisade_embrasure",
}

-- The frame is used to keep the shape of the hole until the concrete is solid
ccb.content.define_construction {
    id = "constr_sconc_wall_embrasure",
    group = "build_sconcrete_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "180 m",
    tools = { { { "concrete_mix_tool", 50 } }, { { "frame_wood", -1 } } },
    qualities = { { { id = "SMOOTH", level = 2 } } },
    components = { { { "concrete", 4 } }, { { "2x4", 12 } }, { { "water", 4 }, { "water_clean", 4 } } },
    pre_terrain = "t_sconc_wall_halfway",
    post_terrain = "t_embrasure_sconc",
}

-- The frame is used to keep the shape of the hole until the concrete is solid
ccb.content.define_construction {
    id = "contr_strconcrete_wall_embrasure",
    group = "build_strconcrete_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 } },
    duration = "120 m",
    tools = { { { "concrete_mix_tool", 50 } }, { { "frame_wood", -1 } } },
    qualities = { { { id = "SMOOTH", level = 2 } } },
    components = { { { "concrete", 6 } }, { { "2x4", 12 } }, { { "water", 4 }, { "water_clean", 4 } } },
    pre_terrain = "t_strconc_wall_halfway",
    post_terrain = "t_embrasure_strconcrete",
}

-- It needs a saw and a bit more time in order to make the hole
ccb.content.define_construction {
    id = "constr_wall_log_embrasure",
    group = "build_log_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "80 m",
    qualities = { { { id = "DIG", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "log", 2 } }, { { "stick", 3 }, { "2x4", 6 } } },
    pre_terrain = "t_wall_log_half",
    post_terrain = "t_embrasure_log",
}

ccb.content.define_construction {
    id = "constr_rock_wall_embrasure",
    group = "build_rock_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 6 }, { "survival", 2 } },
    duration = "180 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "DIG", level = 2 } } },
    components = { { { "rock", 12 } }, { { "mortar_build", 1 }, { "mortar_lime", 1 } } },
    pre_terrain = "t_rock_wall_half",
    post_terrain = "t_embrasure_rock",
}

ccb.content.define_construction {
    id = "constr_wall_wood_embrasure",
    group = "build_wood_wall_embrasure",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 2 } },
    duration = "40 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "wood_sheet", 1 }, { "wood_panel", 2 } }, { { "nails", 20, "LIST" } } },
    pre_terrain = "t_wall_half",
    post_terrain = "t_embrasure_wood",
}
