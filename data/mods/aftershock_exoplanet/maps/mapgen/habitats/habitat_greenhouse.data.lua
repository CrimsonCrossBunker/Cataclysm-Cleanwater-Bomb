local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_center_farm",
    layout = {
        fill_terrain = "t_metal_floor_no_roof",
        nested = { { id = "afs_modular_habitat_center_farm", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_greenhouse_control_ramp",
    layout = {
        fill_terrain = "t_metal_floor_no_roof",
        nested = { { id = "afs_modular_habitat_greenhouse_control_ramp", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_greenhouse",
    layout = {
        fill_terrain = "t_metal_floor_no_roof",
        nested = { { id = "afs_modular_habitat_greenhouse", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_greenhouse_ramp_up",
    layout = {
        fill_terrain = "t_metal_floor_no_roof",
        nested = { { id = "afs_modular_habitat_greenhouse_ramp_up", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_greenhouse_roof_ramp",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "........................",
            "...________..________...",
            "...________..________...",
            "...________..________...",
            "..//_______.._______//..",
            "../________..________/..",
            "..//_______.._______//..",
            "...__________________...",
            "...__________________...",
            "...__________________...",
            "..//________________//..",
            "../__________________/..",
            "../__________________/..",
            "..//________________//..",
            "...__________________...",
            "...__________________...",
            "...__________________...",
            "..//________________//..",
            "../__________________/..",
            "..//________________//..",
            "...__________________...",
            "...======______======...",
            "...=4444=______=4444=...",
            "..//5555|//__//|5555//..",
        },
        palettes = { "afs_habitat_structure" },
        terrain = {
            ["."] = "t_open_air",
            ["5"] = "t_ramp_down_high",
            ["4"] = "t_ramp_down_low",
            ["="] = "t_wall_clearcrete_alarm",
            _ = "t_clearcrete_roof",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_greenhouse_roof_full",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "........................",
            "...________..________...",
            "...________..________...",
            "...________..________...",
            "..//_______.._______//..",
            "../________..________/..",
            "..//_______.._______//..",
            "...__________________...",
            "...__________________...",
            "...__________________...",
            "..//________________//..",
            "../__________________/..",
            "../__________________/..",
            "..//________________//..",
            "...__________________...",
            "...__________________...",
            "...__________________...",
            "..//________________//..",
            "../__________________/..",
            "..//________________//..",
            "...__________________...",
            "...__________________...",
            "...__________________...",
            "..   __    __    __   ..",
        },
        palettes = { "afs_habitat_structure" },
        terrain = { ["."] = "t_open_air", [" "] = "t_metal_floor", _ = "t_clearcrete_roof" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_greenhouse_roof2_ramp",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "...______......______...",
            "...______......______...",
            "..____________________..",
        },
        palettes = { "afs_habitat_structure" },
        terrain = { ["."] = "t_open_air", _ = "t_clearcrete_roof" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_greenhouse_control_ramp_roof",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "..____________________..",
            "..____________________..",
            "________________________",
            "________________________",
            "________________________",
            "________________________",
            "  /__________________/  ",
            "../__________________/..",
            "..////___________ ////..",
            "...../____________/.....",
            "...../____________/.....",
            "....._____::::_____.....",
            "....._____::::_____.....",
            "....._____::::_____.....",
            ".....   ________   .....",
            "....... ________ .......",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
        },
        palettes = { "afs_habitat_structure" },
        terrain = { ["."] = "t_open_air", _ = "t_clearcrete_roof", [" "] = "t_metal_floor_no_roof" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
