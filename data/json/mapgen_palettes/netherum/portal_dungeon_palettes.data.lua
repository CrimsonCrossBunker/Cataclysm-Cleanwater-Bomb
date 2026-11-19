local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "portal_storm_palette",
    layout = {
        terrain = { ["0"] = "t_floor_warped", ["1"] = "t_wall_warped", a = "t_grass_alien", G = "t_grass" },
    },
}

ccb.content.define_mapgen_palette {
    id = "portal_storm_dungeon_palette",
    layout = {
        terrain = {
            [" "] = { { id = "t_floor_warped", copies = 95 }, { id = "t_floor_warped_light", copies = 5 } },
            _ = { { id = "t_floor_warped", copies = 1 }, { id = "t_open_air", copies = 1 } },
            ["-"] = "t_wall_warped",
            ["!"] = "t_floor_warped",
            ["~"] = "t_open_air",
            ["@"] = "t_floor_warped",
            o = { { id = "t_floor_warped", copies = 75 }, { id = "t_wall_warped", copies = 25 } },
            O = { { id = "t_floor_warped", copies = 25 }, { id = "t_wall_warped", copies = 75 } },
            Q = { { id = "t_floor_warped", copies = 20 }, { id = "t_wall_warped", copies = 100 } },
            q = { { id = "t_floor_warped", copies = 50 }, { id = "t_wall_warped", copies = 50 } },
        },
    },
}
