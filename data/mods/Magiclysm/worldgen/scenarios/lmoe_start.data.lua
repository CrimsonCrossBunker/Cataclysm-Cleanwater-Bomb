local ccb = require("ccb")

-- This is done in a nested map to make the flooring under the furniture look right, nothing much else.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe3_storage_mage_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "lllll|     ",
            "u___U|     ",
            "u_u_U|     ",
            "u_u_U|     ",
            "u_u_U|     ",
            "u_u_U|     ",
            "__v_U|     ",
            "u_v_U|     ",
            "u_v_U|     ",
            "u___U|     ",
            "AV_VU|     ",
        },
        palettes = { "bunker", "empty_bunker_items" },
        monster_placements = { { id = "mon_irongolem", x = 0, y = 6, chance = 50 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lmoe3_tankroom_mage_scen_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "_{|l__aa|M_",
            "_{|l__aa||+",
            "_{|l____ll_",
            "_{|l_______",
            "__+________",
            "|||||||||||",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
        },
        palettes = { "bunker", "empty_bunker_items" },
        terrain = { M = "t_metal_floor" },
        furniture = { M = "f_magiclysm_translocator_gate" },
        monster_placements = {
            { id = "mon_krabgek", x = 10, y = 0, chance = 100 },
            { id = "mon_krabgek", x = { 4, 10 }, y = { 0, 4 }, chance = 40, repetitions = { 1, 2 } },
        },
    },
}
