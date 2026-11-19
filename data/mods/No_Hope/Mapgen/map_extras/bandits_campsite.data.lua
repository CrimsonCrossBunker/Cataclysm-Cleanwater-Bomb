local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_campsite",
    layout = {
        nested = { { id = "bandits_campsite", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bandits_campsite",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "       .........        ",
            "       .........        ",
            "       ..V......        ",
            "       .........        ",
            "                        ",
            "                        ",
            "                        ",
            "              @         ",
            "         @              ",
            " ....         r    .... ",
            " ....              .... ",
            " ....              .... ",
            " ..v.    l     l   ..v. ",
            " .... @  l  F  l   .... ",
            " ....    l     l   .... ",
            "                        ",
            "        r   @   r       ",
            "                        ",
            "       .........        ",
            "       .........        ",
            "       ..V......        ",
            "       .........        ",
            "                        ",
            "                        ",
        },
        terrain = { ["."] = "t_dirt", ["@"] = "t_dirt", l = "t_trunk", v = "t_dirt", V = "t_dirt" },
        traps = { r = "tr_rollmat" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        npc_glyphs = { ["@"] = { id = "bandit" } },
        vehicle_glyphs = {
            v = { id = "bandit_vehicles", fuel = 50, status = -1, rotation = 90 },
            V = { id = "bandit_vehicles", fuel = 50, status = -1, rotation = 180 },
        },
        glyph_mappings = {
            F = {
                terrain = "t_dirt",
                furniture = "f_brazier",
                fields = { id = "fd_fire" },
                item_spawns = { id = "log" },
            },
        },
    },
}
