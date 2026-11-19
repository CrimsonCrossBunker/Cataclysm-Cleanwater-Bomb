local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_house_wasp",
    layout = {
        nested = {
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
        },
        nested_glyphs = {
            [" "] = {
                {
                    choices = { { id = "null", weight = 2 }, { id = "1x1_remove_window", weight = 1 } },
                },
                {
                    choices = { { id = "null", weight = 7 }, { id = "1x1_wall_to_paper", weight = 1 } },
                },
            },
        },
        transform_glyphs = { [" "] = { id = "remove_door" } },
        monster_placements = { { group = "GROUP_WASP_QUEEN", x = { 0, 23 }, y = { 0, 23 } } },
        monster_group_placements = { { group = "GROUP_DERMATIK", chance = 20, x = 22, y = 22, density = 0.1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_remove_window",
    layout = {
        size = { width = 1, height = 1 },
        transform_placements = { { id = "remove_window", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_wall_to_paper",
    layout = {
        size = { width = 1, height = 1 },
        transform_placements = { { id = "wall_to_paper", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_wasp_pod",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "123",
            "4 6",
            "789",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_WASP_GUARD", x = 1, y = 1 } },
        parameters = {
            opening = {
                value_type = "string",
                default = { weighted = { "1", "2", "3", "4", "6", "7", "8", "9" } },
                scope = "nested",
            },
        },
        terrain = {
            ["1"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_null",
                    ["2"] = "t_paper",
                    ["3"] = "t_paper",
                    ["4"] = "t_paper",
                    ["6"] = "t_paper",
                    ["7"] = "t_paper",
                    ["8"] = "t_paper",
                    ["9"] = "t_paper",
                },
            },
            ["2"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_null",
                    ["3"] = "t_paper",
                    ["4"] = "t_paper",
                    ["6"] = "t_paper",
                    ["7"] = "t_paper",
                    ["8"] = "t_paper",
                    ["9"] = "t_paper",
                },
            },
            ["3"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_paper",
                    ["3"] = "t_null",
                    ["4"] = "t_paper",
                    ["6"] = "t_paper",
                    ["7"] = "t_paper",
                    ["8"] = "t_paper",
                    ["9"] = "t_paper",
                },
            },
            ["4"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_paper",
                    ["3"] = "t_paper",
                    ["4"] = "t_null",
                    ["6"] = "t_paper",
                    ["7"] = "t_paper",
                    ["8"] = "t_paper",
                    ["9"] = "t_paper",
                },
            },
            ["6"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_paper",
                    ["3"] = "t_paper",
                    ["4"] = "t_paper",
                    ["6"] = "t_null",
                    ["7"] = "t_paper",
                    ["8"] = "t_paper",
                    ["9"] = "t_paper",
                },
            },
            ["7"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_paper",
                    ["3"] = "t_paper",
                    ["4"] = "t_paper",
                    ["6"] = "t_paper",
                    ["7"] = "t_null",
                    ["8"] = "t_paper",
                    ["9"] = "t_paper",
                },
            },
            ["8"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_paper",
                    ["3"] = "t_paper",
                    ["4"] = "t_paper",
                    ["6"] = "t_paper",
                    ["7"] = "t_paper",
                    ["8"] = "t_null",
                    ["9"] = "t_paper",
                },
            },
            ["9"] = {
                select = { parameter = "opening", fallback = "0" },
                cases = {
                    ["1"] = "t_paper",
                    ["2"] = "t_paper",
                    ["3"] = "t_paper",
                    ["4"] = "t_paper",
                    ["6"] = "t_paper",
                    ["7"] = "t_paper",
                    ["8"] = "t_paper",
                    ["9"] = "t_null",
                },
            },
        },
    },
}
