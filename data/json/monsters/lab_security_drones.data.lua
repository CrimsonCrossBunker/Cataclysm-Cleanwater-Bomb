local ccb = require("ccb")

-- Opens bot release if you lack a green maintenance ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "bots_center_garage",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 1,
                y = 11,
                end_x = 1,
                end_y = 12,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_e",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 17, y = 4 },
            { id = "t_thconc_r", x = 17, y = 6 },
            { id = "t_thconc_r", x = 6, y = 4 },
            { id = "t_thconc_r", x = 6, y = 6 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_f",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 17, y = 13 },
            { id = "t_thconc_r", x = 17, y = 15 },
            { id = "t_thconc_r", x = 6, y = 13 },
            { id = "t_thconc_r", x = 6, y = 15 },
        },
    },
}

-- Opens bot release if you lack a light green researcher ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "bot_release_rearcher_green",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 19,
                y = 15,
                end_x = 19,
                end_y = 16,
            },
        },
    },
}

-- Opens bot release if you lack a light green researcher ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "bot_release_rearcher_green_2",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 4,
                y = 15,
                end_x = 4,
                end_y = 16,
            },
        },
    },
}

-- Releases if you lack a black security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "toxic_gas_corridor",
    layout = {
        field_placements = {
            { id = "fd_toxic_gas", x = 0, y = 10, intensity = 2, age_turns = 20 },
            { id = "fd_toxic_gas", x = 3, y = 16, intensity = 2, age_turns = 20 },
            { id = "fd_toxic_gas", x = 20, y = 10, intensity = 2, age_turns = 20 },
            { id = "fd_toxic_gas", x = 23, y = 16, intensity = 2, age_turns = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_c",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 19, y = 8 },
            { id = "t_thconc_r", x = 19, y = 10 },
            { id = "t_thconc_r", x = 4, y = 8 },
            { id = "t_thconc_r", x = 4, y = 10 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_d",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 19, y = 17 },
            { id = "t_thconc_r", x = 19, y = 19 },
            { id = "t_thconc_r", x = 4, y = 17 },
            { id = "t_thconc_r", x = 4, y = 19 },
        },
    },
}
