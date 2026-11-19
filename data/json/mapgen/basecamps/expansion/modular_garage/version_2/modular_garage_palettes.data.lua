local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmg_2_common_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            [";"] = "t_dirt",
            G = "t_palisade_gate",
            p = "t_palisade",
            P = "t_palisade_pulley",
            r = "t_shingle_flat_roof",
        },
        furniture = { [";"] = "f_clear", c = "f_counter", I = "f_rack" },
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_concrete_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_thconc_floor",
            ["+"] = "t_door_metal_c",
            v = "t_window_no_curtains",
            w = "t_sconc_wall",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_log_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor",
            ["+"] = "t_door_c",
            v = "t_window_no_curtains",
            w = "t_wall_log",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_metal_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_scrap_floor",
            ["+"] = "t_door_metal_c",
            v = "t_window_no_curtains",
            w = "t_scrap_wall",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_migo_resin_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor_resin",
            ["+"] = "t_resin_hole_c",
            v = "t_wall_resin_cage",
            w = "t_wall_resin",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_rammed_earth_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor_primitive",
            ["+"] = "t_door_makeshift_c",
            v = "t_window_empty",
            w = "t_wall_rammed_earth",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_rock_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor",
            ["+"] = "t_door_c",
            v = "t_window_no_curtains",
            w = "t_rock_wall",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_wad_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor_primitive",
            ["+"] = "t_door_makeshift_c",
            v = "t_wall_wattle_half",
            w = "t_wall_wattle",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_wood_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor",
            ["+"] = "t_door_c",
            v = "t_window_no_curtains",
            w = "t_wall_wood",
        },
        furniture = {},
    },
}

ccb.content.define_mapgen_palette {
    id = "fbmg_2_brick_palette",
    layout = {
        terrain = {
            [","] = "t_dirtfloor",
            ["."] = "t_floor",
            ["+"] = "t_rdoor_c",
            v = "t_window_no_curtains",
            w = "t_brick_wall",
        },
        furniture = {},
    },
}
