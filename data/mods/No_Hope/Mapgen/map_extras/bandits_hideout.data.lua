local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_hideout",
    layout = {
        nested = { { id = "bandits_hideout", x = 0, y = 0 } },
    },
}

-- TODO: I think translate_ter is legacy and should be replaced with ter_furn_transform
ccb.content.define_mapgen {
    kind = "nested",
    id = "bandits_hideout",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "         @  @           ",
            "                        ",
            "         @    @         ",
            "                        ",
            "             @          ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        rotation = { 0, 3 },
        nested_glyphs = {
            [" "] = {
                choices = {
                    { id = "1x1_boarded_up", weight = 2 },
                    { id = "1x1_boarded_up_rushed", weight = 1 },
                },
            },
        },
        zone_placements = {
            { id = "NPC_NO_INVESTIGATE", faction = "hells_raiders", x = { 0, 23 }, y = { 0, 6 } },
            { id = "NPC_NO_INVESTIGATE", faction = "hells_raiders", x = { 0, 23 }, y = { 17, 23 } },
            { id = "NPC_NO_INVESTIGATE", faction = "hells_raiders", x = { 0, 6 }, y = { 7, 16 } },
            { id = "NPC_NO_INVESTIGATE", faction = "hells_raiders", x = { 17, 23 }, y = { 7, 16 } },
        },
        npc_glyphs = { ["@"] = { id = "bandit" } },
    },
}
