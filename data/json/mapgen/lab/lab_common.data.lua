local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "lab_palette",
    layout = {
        toilets = { "T" },
        item_groups = { T = { group = "SUS_toilet", chance = 50 } },
        furniture = {
            ["6"] = "f_console",
            x = "f_console_broken",
            b = "f_bed",
            l = "f_locker",
            X = { { id = "f_cardboard_box" }, { id = "f_crate_c" } },
            r = "f_rack",
            d = "f_desk",
            s = "f_dresser",
            h = "f_chair",
            f = "f_fridge",
            t = "f_table",
            i = "f_filing_cabinet",
            c = "f_counter",
            S = "f_sink",
            T = "f_toilet",
            ["#"] = "f_null",
            ["]"] = "f_bookcase",
            ["^"] = "f_rubble_rock",
        },
        terrain = {
            g = "t_reinforced_glass",
            G = "t_reinforced_door_glass_lab_c",
            ["."] = "t_thconc_floor",
            [","] = "t_strconc_floor",
            ["-"] = "t_concrete_wall",
            ["|"] = "t_concrete_wall",
            ["+"] = "t_door_glass_frosted_lab_c",
            W = "t_door_lab_c",
            M = "t_door_metal_lab_c",
            L = "t_door_metal_locked",
            ["#"] = "t_rock",
        },
    },
}

-- Shock vent which spews electricity every ~10th turn.
ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_fd_shock_vent",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_shock_vent", x = 0, y = 0 } },
    },
}
