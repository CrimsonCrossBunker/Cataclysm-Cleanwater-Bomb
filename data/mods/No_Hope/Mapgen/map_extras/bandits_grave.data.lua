local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_grave",
    layout = {
        nested = { { id = "bandits_grave", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bandits_grave",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "  .........             ",
            "  .PPP.PPP.             ",
            "  .PPP.PPP.             ",
            "  .PPP.PPP.             ",
            "  .........             ",
            "  .PPP.PPP.             ",
            "  .PPP.PPP.             ",
            "  .PPP.PPP.             ",
            "  .........             ",
            "                        ",
            "          @             ",
            "           @            ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { ["."] = "t_dirt", ["@"] = "t_dirt" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        npc_glyphs = { ["@"] = { id = "bandit" } },
        glyph_mappings = {
            P = {
                terrain = "t_pit",
                fields = { id = "fd_blood" },
                item_spawns = { id = "corpse", repetitions = { 1, 3 } },
            },
        },
    },
}
