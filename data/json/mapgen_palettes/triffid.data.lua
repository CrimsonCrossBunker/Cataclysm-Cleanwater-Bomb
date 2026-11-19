local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "triffid",
    layout = {
        nested_glyphs = {
            ["0"] = {
                choices = {
                    { id = "1x1_triffid_field_furniture", weight = 25 },
                    { id = "null", weight = 175 },
                },
            },
            ["1"] = {
                choices = {
                    { id = "1x1_triffid_field_terrain", weight = 9 },
                    { id = "1x1_triffid_field_furniture", weight = 25 },
                    { id = "null", weight = 166 },
                },
            },
            ["2"] = {
                choices = {
                    { id = "1x1_triffid_field_terrain", weight = 15 },
                    { id = "1x1_triffid_field_furniture", weight = 35 },
                    { id = "null", weight = 150 },
                },
            },
        },
        terrain = {
            ["#"] = "t_triffid_bark_wall",
            C = "t_barkfloor",
            ["~"] = "t_triffid_wood_wall",
            [","] = "t_triffid_leaves",
            P = "t_root_wall",
            ["."] = "t_root_floor",
            D = { { id = "t_bramble_door_c" }, { id = "t_bramble_door_o" } },
            I = {
                { id = "t_region_tree_fruit", copies = 2 },
                { id = "t_mega_fern", copies = 8 },
                { id = "t_region_tree", copies = 1 },
                { id = "t_underbrush", copies = 1 },
                { id = "t_shrub", copies = 1 },
            },
        },
        furniture = {
            T = "f_glowingbulb",
            ["@"] = "f_brambles",
            i = { { id = "f_mutpoppy" }, { id = "f_region_flower" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_triffid_field_terrain",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "I",
        },
        palettes = { "triffid" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_triffid_field_furniture",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "i",
        },
        palettes = { "triffid" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        transform_placements = { { id = "remove_forest_terrain_plants", x = 0, y = 0 } },
    },
}
