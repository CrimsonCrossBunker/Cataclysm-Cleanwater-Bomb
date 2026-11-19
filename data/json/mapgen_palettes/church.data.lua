local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "church",
    layout = {
        toilets = { "T" },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Church Bells 1.2"),
                menu = {
                    { label = ccb.content.text("Gathering Toll"), action = "toll" },
                    { label = ccb.content.text("Wedding Toll"), action = "toll" },
                    { label = ccb.content.text("Funeral Toll"), action = "toll" },
                },
            },
        },
        item_groups = {
            ["#"] = { group = "church", chance = 40 },
            [","] = { group = "church", chance = 5 },
            ["."] = { group = "church", chance = 5 },
            L = { group = "SUS_janitors_closet", chance = 80 },
            T = { group = "SUS_toilet", chance = 50 },
            l = { group = "jackets", chance = 60 },
        },
        terrain = {
            [" "] = "t_region_groundcover_urban",
            ["+"] = "t_door_c",
            ["."] = "t_floor",
            S = "t_linoleum_gray",
            T = "t_linoleum_gray",
            ["'"] = "t_linoleum_gray",
            ["="] = "t_door_locked_alarm",
            ["-"] = "t_door_locked",
            O = "t_column",
            ["^"] = "t_region_shrub_decorative",
            s = "t_sidewalk",
            w = "t_window",
            ["|"] = "t_wall_w",
            ["<"] = "t_stairs_up",
        },
        furniture = {
            b = "f_brazier",
            ["#"] = "f_bench",
            S = "f_sink",
            c = "f_counter",
            d = "f_desk",
            e = "f_fridge",
            h = "f_chair",
            l = "f_rack_coat",
            L = "f_locker",
            o = "f_bookcase",
            t = "f_table",
            C = "f_crate_c",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
            p = "f_piano",
            D = "f_wardrobe",
        },
    },
}
