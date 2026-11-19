local ccb = require("ccb")

-- removes pablo and dana nunez from the refugee center
ccb.content.define_mapgen {
    kind = "update",
    id = "refcenter_nunez_departure",
    layout = {
        npc_removals = {
            { id = "refugee_DanaNunez", x = 11, y = 13 },
            { id = "refugee_PabloNunez", x = 11, y = 12 },
        },
    },
}

-- In addition to basic mapgen, adds some point variables in the hopes that I can add some passive movement animations for pablo and dana.
ccb.content.define_mapgen {
    kind = "update",
    id = "tacoma_nunez_trailer_arrive",
    layout = {
        flags = { "NO_UNDERLYING_ROTATE" },
        nested = { { x = 5, y = 15, id = "nunez_trailer" } },
    },
}

-- Nunez bakery inside a silver bullet trailer.
-- The stuff in 'ABCDE' should potentially also be made into some new furniture such as piles of stored wood or a propane tank, but this works for the moment.  The purpose is just to stop players from easily getting up to the back wall and interacting through it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "nunez_trailer",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "ABCDE ",
            "123456",
            "7.;:89",
            "0a_bcd",
            "efghij",
            "      ",
        },
        rotation = { 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { x = 0, y = 0, z = 1, id = "nunez_trailer_roof" } },
        npc_placements = { { id = "tacoma_DanaNunez", x = 4, y = 2 }, { id = "tacoma_PabloNunez", x = 4, y = 3 } },
        tile_edits = {
            { shape = "point", operation = "remember_position", id = "Pablo_relax", x = 4, y = 3 },
            { shape = "point", operation = "remember_position", id = "Dana_baking", x = 4, y = 2 },
        },
        terrain = {
            ["1"] = "t_bullettrailer_nwall_westcorner",
            ["2"] = "t_bullettrailer_nwall",
            ["3"] = "t_bullettrailer_nwall_window",
            ["4"] = "t_bullettrailer_nwall",
            ["5"] = "t_bullettrailer_nwall",
            ["6"] = "t_bullettrailer_nwall_eastcorner",
            ["7"] = "t_bullettrailer_wwall",
            ["."] = "t_bullettrailer_brownfloor",
            [":"] = "t_bullettrailer_brownfloor",
            [";"] = "t_bullettrailer_brownfloor",
            ["8"] = "t_bullettrailer_inner_door",
            ["9"] = "t_bullettrailer_ewall",
            ["0"] = "t_bullettrailer_wwall",
            a = "t_bullettrailer_brownfloor",
            _ = "t_bullettrailer_brownfloor",
            b = "t_bullettrailer_brownfloor",
            c = "t_bullettrailer_inner_T",
            d = "t_bullettrailer_inner_eastcorner",
            e = "t_bullettrailer_swall_westcorner",
            f = "t_bullettrailer_swall_windows",
            g = "t_bullettrailer_swall_door",
            h = "t_bullettrailer_swall_wheels",
            i = "t_bullettrailer_swall",
            j = "t_bullettrailer_swall_eastcorner",
        },
        furniture = {
            A = "f_crate_c",
            B = "f_standing_tank",
            C = "f_standing_tank",
            D = "f_crate_c",
            E = "f_crate_c",
            ["1"] = "f_bullettrailer_table_top",
            ["7"] = "f_bullettrailer_table_middle",
            ["."] = "f_bullettrailer_cabinet",
            [";"] = "f_bullettrailer_sink",
            [":"] = "f_bullettrailer_desk",
            ["0"] = "f_bullettrailer_table_bottom",
            a = "f_bullettrailer_minisofa",
            b = "f_bullettrailer_bed_foot",
            c = "f_bullettrailer_bed_head",
            d = "f_bullettrailer_toilet",
            i = "f_bullettrailer_sign_danabakery",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nunez_trailer_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "......",
            "......",
            "......",
            "......",
            "      ",
        },
        rotation = { 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = { ["."] = "t_bullettrailer_roof" },
    },
}
