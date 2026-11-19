local ccb = require("ccb")

-- Used by apartment complexes and multi-unit housings
ccb.content.define_mapgen_palette {
    id = "apt_complex",
    layout = {
        parameters = {
            railing_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_wall_glass", weight = 3 },
                        { id = "t_metal_railing", weight = 3 },
                        { id = "t_glass_railing", weight = 4 },
                        { id = "t_concrete_railing", weight = 6 },
                    },
                },
            },
            floor_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_linoleum_white_yellow", weight = 2 },
                        { id = "t_carpet_linoleum_white_green", weight = 2 },
                        { id = "t_carpet_linoleum_white_purple", weight = 1 },
                        { id = "t_carpet_linoleum_white_red", weight = 2 },
                        { id = "t_linoleum_white", weight = 12 },
                        { id = "t_carpet_linoleum_gray_yellow", weight = 2 },
                        { id = "t_carpet_linoleum_gray_green", weight = 2 },
                        { id = "t_carpet_linoleum_gray_purple", weight = 1 },
                        { id = "t_carpet_linoleum_gray_red", weight = 2 },
                        { id = "t_linoleum_gray", weight = 4 },
                    },
                },
            },
        },
        palettes = { "parametrized_walls_palette" },
        terrain = {
            ["/"] = "t_null",
            ["."] = "t_open_air",
            ["*"] = {
                { id = "t_door_locked_peep", copies = 2 },
                { id = "t_door_locked_alarm" },
                { id = "t_door_locked_interior", copies = 10 },
                { id = "t_door_c" },
            },
            ["="] = { parameter = "railing_type", fallback = "t_concrete_railing" },
            ["~"] = { parameter = "floor_type", fallback = "t_linoleum_white" },
            ["'"] = "t_linoleum_gray",
            ["`"] = "t_thconc_floor",
            ["^"] = "t_elevator",
            ["˘"] = "t_ladder_up_down",
            ["0"] = "t_grate",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
        },
    },
}

-- Used by apartment complexes and multi-unit housings
ccb.content.define_mapgen_palette {
    id = "apt_complex_ground",
    layout = {
        palettes = { "apt_complex" },
        parameters = {
            fencing_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_region_shrub_decorative", weight = 4 },
                        { id = "t_region_soil", weight = 4 },
                        { id = "t_region_groundcover_urban", weight = 7 },
                        { id = "t_chainfence", weight = 4 },
                        { id = "t_fence", weight = 3 },
                        { id = "t_privacy_fence", weight = 3 },
                        { id = "t_drystone_wall_half", weight = 4 },
                    },
                },
            },
            shrubbery_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_region_soil", weight = 1 },
                        { id = "t_region_groundcover", weight = 1 },
                        { id = "t_region_groundcover_urban", weight = 1 },
                        { id = "t_region_shrub_decorative", weight = 1 },
                    },
                },
            },
            walkway_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_region_groundcover_urban", weight = 1 },
                        { id = "t_concrete", weight = 1 },
                        { id = "t_railroad_rubble", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["."] = "t_region_groundcover_urban",
            ["Ŧ"] = { parameter = "fencing_type", fallback = "t_region_groundcover_urban" },
            ["-"] = { parameter = "walkway_type", fallback = "t_concrete" },
            ["%"] = { parameter = "shrubbery_type", fallback = "t_region_groundcover_urban" },
        },
        furniture = {
            ["Ŧ"] = {
                select = { parameter = "fencing_type", fallback = "t_region_soil" },
                cases = {
                    t_region_shrub_decorative = "f_null",
                    t_region_soil = "f_hedge_short",
                    t_region_groundcover_urban = "f_null",
                    t_chainfence = "f_null",
                    t_fence = "f_null",
                    t_privacy_fence = "f_null",
                    t_drystone_wall_half = "f_null",
                },
            },
            ["%"] = {
                select = { parameter = "shrubbery_type", fallback = "t_region_soil" },
                cases = {
                    t_region_shrub_decorative = "f_null",
                    t_region_soil = "f_hedge_short",
                    t_region_groundcover_urban = "f_null",
                    t_region_groundcover = "f_region_flower_decorative",
                },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "apt_complex_garage",
    layout = {
        vehicle_glyphs = {
            N = { id = "parking_garage", chance = 33, rotation = 270 },
            E = { id = "parking_garage", chance = 33, rotation = 0 },
            S = { id = "parking_garage", chance = 33, rotation = 90 },
            W = { id = "parking_garage", chance = 33, rotation = 180 },
        },
        terrain = {
            ["~"] = "t_pavement",
            ["*"] = "t_door_metal_c",
            ["="] = "t_door_metal_locked",
            ["0"] = "t_gates_mech_control_lab",
            ["["] = "t_thconc_y",
            ["'"] = "t_linoleum_white",
        },
    },
}
