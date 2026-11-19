local ccb = require("ccb")

-- Intended as a palette for randomized interior and exterior walls
ccb.content.define_mapgen_palette {
    id = "parametrized_walls_palette",
    layout = {
        nested_glyphs = {
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 1 },
                    { id = "general_graffiti", weight = 1 },
                    { id = "null", weight = 598 },
                },
            },
        },
        parameters = {
            interior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_wall_b", weight = 5 },
                        { id = "t_wall_g", weight = 5 },
                        { id = "t_wall_p", weight = 1 },
                        { id = "t_wall_P", weight = 1 },
                        { id = "t_wall_r", weight = 3 },
                        { id = "t_wall_w", weight = 15 },
                        { id = "t_wall_y", weight = 3 },
                        { id = "t_wall_gray", weight = 3 },
                        { id = "t_wall_brown", weight = 3 },
                        { id = "t_wall_cyan", weight = 1 },
                        { id = "t_wall_black", weight = 3 },
                        { id = "t_wall_orange", weight = 3 },
                        { id = "t_brick_wall", weight = 2 },
                    },
                },
            },
            exterior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_brick_wall", weight = 4 },
                        { id = "t_wall_wood", weight = 2 },
                        { id = "t_wall_w", weight = 4 },
                        { id = "t_wall_gray", weight = 2 },
                        { id = "t_concrete_wall", weight = 2 },
                        { id = "t_concrete_wall_w", weight = 4 },
                        { id = "t_concrete_wall_gray", weight = 2 },
                        { id = "t_strconc_wall", weight = 1 },
                        { id = "t_strconc_wall_w", weight = 2 },
                        { id = "t_strconc_wall_gray", weight = 1 },
                        { id = "t_sconc_wall", weight = 1 },
                        { id = "t_sconc_wall_w", weight = 2 },
                        { id = "t_sconc_wall_gray", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["|"] = { parameter = "interior_wall_type", fallback = "t_wall_w" },
            ["#"] = { parameter = "exterior_wall_type", fallback = "t_brick_wall" },
        },
    },
}

-- Intended as a palette for randomized walls for multi-story buildings
ccb.content.define_mapgen_palette {
    id = "parametrized_highrise_walls_palette",
    layout = {
        parameters = {
            interior_highrise_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_strconc_wall", weight = 1 },
                        { id = "t_strconc_wall_b", weight = 1 },
                        { id = "t_strconc_wall_g", weight = 1 },
                        { id = "t_strconc_wall_r", weight = 1 },
                        { id = "t_strconc_wall_w", weight = 10 },
                        { id = "t_strconc_wall_p", weight = 1 },
                        { id = "t_strconc_wall_P", weight = 1 },
                        { id = "t_strconc_wall_y", weight = 1 },
                        { id = "t_strconc_wall_orange", weight = 1 },
                        { id = "t_strconc_wall_gray", weight = 2 },
                        { id = "t_strconc_wall_brown", weight = 1 },
                        { id = "t_strconc_wall_cyan", weight = 1 },
                        { id = "t_strconc_wall_black", weight = 1 },
                    },
                },
            },
            exterior_highrise_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_strconc_wall", weight = 1 },
                        { id = "t_strconc_wall_w", weight = 3 },
                        { id = "t_strconc_wall_gray", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["|"] = { parameter = "interior_highrise_wall_type", fallback = "t_strconc_wall" },
            ["#"] = { parameter = "exterior_highrise_wall_type", fallback = "t_strconc_wall" },
        },
    },
}

-- Intended as a palette for randomized fences
ccb.content.define_mapgen_palette {
    id = "parametrized_fences_palette",
    layout = {
        parameters = {
            fence_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_splitrail_fence", weight = 3 },
                        { id = "t_chainfence", weight = 2 },
                        { id = "t_fence", weight = 2 },
                        { id = "t_privacy_fence", weight = 1 },
                        { id = "t_drystone_wall_half", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["Ŧ"] = { parameter = "fence_type", fallback = "t_fence" },
            ["ɤ"] = {
                select = { parameter = "fence_type", fallback = "t_fence" },
                cases = {
                    t_splitrail_fence = "t_splitrail_fencegate_c",
                    t_chainfence = "t_chaingate_c",
                    t_fence = "t_fencegate_c",
                    t_privacy_fence = "t_privacy_fencegate_c",
                    t_drystone_wall_half = "t_chaingate_l",
                },
            },
        },
    },
}

-- Intended as a palette for randomized linoleum
ccb.content.define_mapgen_palette {
    id = "parametrized_linoleum_palette",
    layout = {
        parameters = {
            linoleum_color = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_linoleum_gray", weight = 1 },
                        { id = "t_linoleum_white", weight = 1 },
                    },
                },
            },
        },
        terrain = { ["~"] = { parameter = "linoleum_color", fallback = "t_linoleum_gray" } },
    },
}

-- Use to randomly assign carpet colors
ccb.content.define_mapgen_palette {
    id = "parametrized_carpets_palette",
    layout = {
        parameters = {
            carpet_color_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_red", weight = 1 },
                        { id = "t_carpet_green", weight = 1 },
                        { id = "t_carpet_purple", weight = 1 },
                        { id = "t_carpet_yellow", weight = 1 },
                    },
                },
            },
        },
        terrain = { ["="] = { parameter = "carpet_color_type", fallback = "t_carpet_red" } },
    },
}

-- Use to randomly assign carpet colors(for use in carpets that only occur in nested mapgen)
ccb.content.define_mapgen_palette {
    id = "parametrized_carpets_nest_palette",
    layout = {
        parameters = {
            carpet_color_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_red", weight = 1 },
                        { id = "t_carpet_green", weight = 1 },
                        { id = "t_carpet_purple", weight = 1 },
                        { id = "t_carpet_yellow", weight = 1 },
                    },
                },
                scope = "nested",
            },
        },
        terrain = { ["="] = { parameter = "carpet_color_type", fallback = "t_carpet_red" } },
    },
}

-- Use to randomly assign carpet colors
ccb.content.define_mapgen_palette {
    id = "parametrized_concrete_carpets_palette",
    layout = {
        parameters = {
            concrete_carpet_color_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_concrete_red", weight = 1 },
                        { id = "t_carpet_concrete_green", weight = 1 },
                        { id = "t_carpet_concrete_purple", weight = 1 },
                        { id = "t_carpet_concrete_yellow", weight = 1 },
                    },
                },
            },
        },
        terrain = { ["="] = { parameter = "concrete_carpet_color_type", fallback = "t_carpet_red" } },
    },
}

ccb.content.define_mapgen_palette {
    id = "parametrized_roof_palette",
    layout = {
        palettes = { "roof_palette" },
        parameters = {
            roof_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_flat_roof", weight = 3 },
                        { id = "t_shingle_flat_roof", weight = 2 },
                        { id = "t_tile_flat_roof", weight = 2 },
                        { id = "t_concrete_roof", weight = 1 },
                        { id = "t_brick_roof", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["."] = { parameter = "roof_type", fallback = "t_flat_roof" },
            ["&"] = { parameter = "roof_type", fallback = "t_flat_roof" },
            [":"] = { parameter = "roof_type", fallback = "t_flat_roof" },
            X = { parameter = "roof_type", fallback = "t_flat_roof" },
            ["="] = { parameter = "roof_type", fallback = "t_flat_roof" },
            A = { parameter = "roof_type", fallback = "t_flat_roof" },
            b = { parameter = "roof_type", fallback = "t_flat_roof" },
            c = { parameter = "roof_type", fallback = "t_flat_roof" },
            t = { parameter = "roof_type", fallback = "t_flat_roof" },
            r = { parameter = "roof_type", fallback = "t_flat_roof" },
            L = { parameter = "roof_type", fallback = "t_flat_roof" },
            C = { parameter = "roof_type", fallback = "t_flat_roof" },
            Y = { parameter = "roof_type", fallback = "t_flat_roof" },
            y = { parameter = "roof_type", fallback = "t_flat_roof" },
            ["Я"] = { parameter = "roof_type", fallback = "t_flat_roof" },
            M = { parameter = "roof_type", fallback = "t_flat_roof" },
        },
    },
}
