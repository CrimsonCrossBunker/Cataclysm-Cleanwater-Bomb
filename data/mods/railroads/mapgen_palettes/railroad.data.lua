local ccb = require("ccb")

-- mapgendata::first_predecessor doesn't work perfectly so use 9 to overwrite other nests
ccb.content.define_mapgen_palette {
    id = "railroad_palette",
    layout = {
        terrain = {
            ["^"] = "t_railroad_rubble",
            ["-"] = "t_railroad_tie",
            ["/"] = "t_railroad_tie_d",
            D = "t_railroad_track_d",
            X = "t_railroad_track",
            x = "t_railroad_track_on_tie",
            S = "t_buffer_stop",
            [" "] = "t_region_groundcover",
            ["."] = { { id = "t_railroad_rubble", copies = 2 }, { id = "t_region_groundcover" } },
            ["9"] = "t_region_groundcover_urban",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "railroad",
    layout = {
        terrain = {
            [" "] = "t_region_groundcover_urban",
            ["."] = "t_pavement",
            ["Á"] = "t_pavement",
            [":"] = "t_pavement_y",
            ["]"] = "t_sidewalk",
            _ = "t_concrete",
            ["^"] = "t_railroad_rubble",
            t = "t_railroad_tie",
            ["-"] = "t_railroad_tie_h",
            ["|"] = "t_railroad_tie_v",
            ["/"] = "t_railroad_tie_d",
            X = "t_railroad_track",
            H = "t_railroad_track_h",
            V = "t_railroad_track_v",
            D = "t_railroad_track_d",
            E = "t_railroad_track_d1",
            F = "t_railroad_track_d2",
            x = "t_railroad_track_on_tie",
            h = "t_railroad_track_h_on_tie",
            v = "t_railroad_track_v_on_tie",
            d = "t_railroad_track_d_on_tie",
            ["1"] = "t_railroad_crossing_signal",
            ["2"] = { { id = "t_crossbuck_wood" }, { id = "t_crossbuck_metal" } },
            S = "t_buffer_stop",
            r = "t_railing",
            ["3"] = "t_railroad_track_recessed",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "railroad_station",
    layout = {
        toilets = { "T" },
        item_groups = {
            ["!"] = { group = "SUS_trash_trashcan", chance = 30 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 30 },
            B = {
                { group = "magazines", chance = 10 },
                { group = "novels", chance = 10 },
                { group = "alcohol", chance = 5 },
                { group = "snacks", chance = 20 },
                { group = "manuals", chance = 2 },
            },
            C = {
                { group = "SUS_office_desk", chance = 30 },
                { group = "cash_register_random", chance = 100 },
            },
            T = { group = "SUS_toilet", chance = 50 },
            a = { group = "SUS_trash_trashcan", chance = 30 },
            b = {
                { group = "snacks", chance = 10 },
                { group = "novels", chance = 10 },
                { group = "alcohol", chance = 5 },
            },
            d = { group = "SUS_office_desk", chance = 30 },
            l = { group = "clothing_work_set", chance = 30 },
        },
        vehicle_glyphs = { ["Á"] = { id = "parkinglotbasic", chance = 15, rotation = 180 } },
        terrain = {
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
            ["#"] = "t_concrete_wall",
            ["$"] = "t_chainfence",
            [","] = "t_thconc_floor",
            b = "t_thconc_floor",
            a = "t_thconc_floor",
            ["+"] = "t_door_c",
            ["["] = "t_floor",
            d = "t_floor",
            ["'"] = "t_linoleum_white",
            T = "t_linoleum_white",
            s = "t_linoleum_white",
            ["&"] = "t_linoleum_white",
            I = "t_column",
            ["8"] = "t_concrete",
            ["9"] = "t_concrete",
            O = "t_window",
            o = "t_window_open",
            ["4"] = "t_gutter_downspout",
        },
        furniture = {
            C = "f_counter",
            b = "f_bench",
            B = "f_bench",
            c = "f_chair",
            d = "f_desk",
            f = "f_sofa",
            l = "f_locker",
            s = "f_sink",
            T = "f_toilet",
            ["!"] = "f_trashcan",
            a = "f_trashcan",
            ["&"] = "f_trashcan",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "railroad_station_under",
    layout = {
        terrain = {
            [" "] = "t_soil",
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
            ["#"] = "t_concrete_wall",
            _ = "t_thconc_floor",
            I = "t_column",
        },
    },
}
