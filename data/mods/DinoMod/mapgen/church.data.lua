local ccb = require("ccb")

-- Swamper Church
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "church" },
    weight = 3000,
    layout = {
        rows = {
            "         ^^^^^^         ",
            "     ||||||||||||||     ",
            "    ||dhy|.6ooo.ll||    ",
            "    |D...+.........-sss ",
            "  ^^|||+||||||||+|||^^s ",
            "  ^||yy...,,,,...yy||^s ",
            "   ♡p...b.,tt,.b....♡ s ",
            "   |......,,,,......| s ",
            "  ^♡.......,,.......♡^s ",
            "  ^|.######,,######.|^s ",
            "  ^♡.......,,.......♡^s ",
            "  ^|.######,,######.|^s ",
            "   ♡.......,,.......♡ s ",
            "   |.######,,######.| s ",
            "  ^♡.......,,.......♡^s ",
            "  ^|.######,,######.|^s ",
            "  ^|y......,,......y|^s ",
            "   ||♡|||||,,|||||♡|| s ",
            "    ^^|ll|<,,y|ST|^^  s ",
            "     ^|....,,.+..|^   s ",
            "      |||||++|||||    s ",
            "         O ss O       s ",
            "     ^^    ss    ^^   s ",
            "     ^^    ss    ^^   s ",
        },
        terrain = { ["♡"] = "t_window_enhanced", [" "] = "t_region_soil", ["^"] = "t_region_shrub" },
        palettes = { "church" },
        fill_terrain = "t_floor",
        rotation = { 2, 2 },
        nested = { { id = "NC_BO_BARONYX_spawn", x = 12, y = 5 } },
        item_groups = {
            ["#"] = { group = "butcher_tools", chance = 40 },
            ["."] = { group = "butcher_tools", chance = 5 },
            d = { group = "office_DinoLab", chance = 30 },
            o = { group = "butcher_tools", chance = 40 },
        },
        npc_placements = {
            { id = "guard", x = 7, y = 7 },
            { id = "guard", x = 7, y = 11 },
            { id = "guard", x = 14, y = 7 },
            { id = "guard", x = 14, y = 11 },
            { id = "guard", x = 17, y = 7 },
            { id = "guard", x = 17, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "NC_BO_BARONYX_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "SWAMPER_Bo_Baronyx", x = 0, y = 0 } },
    },
}
