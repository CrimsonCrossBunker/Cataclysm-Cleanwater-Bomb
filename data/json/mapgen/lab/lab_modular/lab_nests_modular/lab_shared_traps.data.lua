local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "concrete_wall_o_lab_res_8_NW",
    layout = {
        terrain_placements = { { id = "t_thconc_r", x = 11, y = 15 }, { id = "t_thconc_r", x = 11, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "concrete_wall_o_lab_res_8_NE",
    layout = {
        terrain_placements = { { id = "t_thconc_r", x = 12, y = 15 }, { id = "t_thconc_r", x = 12, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_res_8_NW",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 9, y = 3 },
            { id = "t_thconc_floor_olight", x = 9, y = 11 },
            { id = "t_thconc_floor_olight", x = 9, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_res_8_NE",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 14, y = 3 },
            { id = "t_thconc_floor_olight", x = 14, y = 11 },
            { id = "t_thconc_floor_olight", x = 14, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_res_8_SW",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 9, y = 3 },
            { id = "t_thconc_floor_olight", x = 9, y = 11 },
            { id = "t_thconc_floor_olight", x = 20, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_res_8_SE",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 14, y = 3 },
            { id = "t_thconc_floor_olight", x = 14, y = 11 },
            { id = "t_thconc_floor_olight", x = 3, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_lab_security_z0N_A",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 4, y = 3 },
            { id = "t_thconc_floor_olight", x = 11, y = 15 },
            { id = "t_thconc_floor_olight", x = 18, y = 3 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_lab_security_z0N_B",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 4, y = 15 },
            { id = "t_thconc_floor_olight", x = 11, y = 3 },
            { id = "t_thconc_floor_olight", x = 18, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_lab_security_z0S_A",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 4, y = 8 },
            { id = "t_thconc_floor_olight", x = 11, y = 20 },
            { id = "t_thconc_floor_olight", x = 18, y = 8 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "light_on_lab_security_z0S_B",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        terrain_placements = {
            { id = "t_thconc_floor_olight", x = 4, y = 20 },
            { id = "t_thconc_floor_olight", x = 11, y = 8 },
            { id = "t_thconc_floor_olight", x = 18, y = 20 },
        },
    },
}
