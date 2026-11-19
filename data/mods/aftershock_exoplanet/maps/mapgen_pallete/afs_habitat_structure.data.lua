local ccb = require("ccb")

-- ["HOW THE KEYS OF THESE PALLETES ARE ASSIGNED.", "Structural and common immovable elements (aka doors, bathroom fixtures) are keyed to symbols.", "Common fixtures (use this term because some furniture style elements are actually terrains for game purposes) use letters", "Numbers and tilded characters deliberately left unoccupied so that individual pieces of mapgen can use them to spawn custom stuff."]
ccb.content.define_mapgen_palette {
    id = "afs_habitat_structure",
    layout = {
        toilets = { "&" },
        item_groups = { ["&"] = { group = "SUS_toilet", chance = 50 } },
        terrain = {
            [" "] = "t_region_groundcover_urban",
            ["."] = "t_metal_floor",
            [","] = "t_metal_floor_olight",
            ["'"] = "t_metal_floor_olight_inactive",
            ["$"] = "t_grate",
            ["{"] = "t_linoleum_white",
            ["}"] = "t_linoleum_whitefloor_olight",
            [";"] = "t_linoleum_white_olight_inactive",
            ["/"] = "t_wall_prefab_metal",
            ["="] = {
                { id = "t_wall_prefab_glass", copies = 2 },
                { id = "t_wall_prefab_glass_shutters", copies = 2 },
                { id = "t_wall_prefab_bglass_shutters", copies = 4 },
                { id = "t_wall_prefab_bglass", copies = 5 },
            },
            ["-"] = "t_wall_metal",
            ["|"] = "t_concrete_wall",
            [")"] = "t_reinforced_glass",
            ["["] = "t_metal_railing",
            ["]"] = { { id = "t_door_glass_c", copies = 5 }, { id = "t_door_glass_o" } },
            ["+"] = {
                { id = "t_door_locked", copies = 1 },
                { id = "t_door_c", copies = 5 },
                { id = "t_door_o", copies = 1 },
            },
            [":"] = {
                { id = "t_door_locked_interior", copies = 1 },
                { id = "t_door_c", copies = 5 },
                { id = "t_door_o", copies = 5 },
            },
            ["!"] = {
                { id = "t_door_metal_c", copies = 5 },
                { id = "t_door_metal_pickable", copies = 3 },
                { id = "t_door_metal_locked", copies = 1 },
                { id = "t_door_metal_o", copies = 5 },
            },
            ["#"] = "t_metal_ventilation_shutter",
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
        },
        furniture = {
            ["~"] = "f_habitat_bathroom",
            ["^"] = "f_sink",
            ["*"] = "f_sink",
            ["%"] = "f_fireman_cabinet",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_habitat_exterior",
    layout = {
        terrain = {
            ["™"] = "t_region_groundcover_urban",
            ["℗"] = "t_region_shrub_decorative",
            ["©"] = "t_sidewalk",
            ["¢"] = "t_pavement",
            ["†"] = "t_pavement_y",
            ["°"] = "t_thconc_floor_no_roof",
            ["£"] = "t_flat_roof",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_habitat_connection_tube",
    layout = {
        terrain = {
            ["."] = "t_metal_floor",
            ["/"] = "t_wall_prefab_metal",
            ["="] = {
                { id = "t_wall_prefab_glass", copies = 2 },
                { id = "t_wall_prefab_glass_shutters", copies = 2 },
                { id = "t_wall_prefab_bglass_shutters", copies = 4 },
                { id = "t_wall_prefab_bglass", copies = 5 },
            },
            ["]"] = { { id = "t_door_glass_c", copies = 5 }, { id = "t_door_glass_o" } },
        },
        furniture = { ["."] = "f_null", ["/"] = "f_null", ["="] = "f_null", ["]"] = "f_null" },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_habitat_mech_furnishing",
    layout = {
        liquid_glyphs = { W = { id = "water_clean", amount = { 0, 100 } } },
        item_groups = {
            ["%"] = { group = "afs_tools_space_emergency" },
            ["@"] = { group = "bed", chance = 50 },
            k = { group = "SUS_office_desk", chance = 60 },
            l = { group = "afs_frontier_cryo_g", chance = 50 },
            q = {
                { group = "tools_robotics", chance = 5, repetitions = { 2, 5 } },
                { group = "afs_tools_structural_repair", chance = 20, repetitions = { 2, 5 } },
            },
            v = { group = "SUS_trash_trashcan", chance = 30, repetitions = { 1, 4 } },
            y = { { group = "afs_tools_electric_repair", chance = 20, repetitions = { 2, 5 } } },
        },
        terrain = { p = "t_sewage_pipe" },
        furniture = {
            ["@"] = "f_bed",
            f = "f_workbench",
            y = "f_workbench",
            c = "f_console_broken",
            h = "f_chair",
            P = "f_water_purifier",
            W = "f_water_heater",
            A = "f_air_filter",
            E = "f_machinery_electronic",
            L = "f_machinery_light",
            H = "f_machinery_heavy",
            O = "f_ECU",
            T = "f_cryofluid_pump",
            p = "f_solar_unit",
            F = "f_fridge",
            j = "f_counter",
            q = "f_rack",
            r = "f_bookcase",
            v = "f_trashcan",
            l = "f_locker",
            k = "f_desk",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_habitat_residential_furnishing",
    layout = {
        item_groups = {
            F = { group = "afs_old_food_storage", chance = 60 },
            U = { group = "afs_old_food_storage", chance = 60 },
            l = { group = "afs_wintersuit_generic_basic", chance = 30 },
            o = { group = "afs_kitchenette", chance = 60 },
        },
        palettes = { "afs_habitat_residential_furnishing_looted" },
    },
}

-- Defines the furniture ids and loot items that aren't valuable enough to steal.
ccb.content.define_mapgen_palette {
    id = "afs_habitat_residential_furnishing_looted",
    layout = {
        item_groups = {
            ["@"] = { group = "bed", chance = 50 },
            W = { group = "afs_colonist_outfit", chance = 60 },
            v = { group = "SUS_trash_trashcan", chance = 30, repetitions = { 1, 4 } },
        },
        furniture = {
            ["@"] = "f_bed",
            S = "f_sleep_pod",
            f = "f_workbench",
            F = "f_fridge",
            y = "f_metal_table",
            c = "f_console_broken",
            h = "f_chair",
            b = "f_bench",
            H = "f_armchair",
            j = "f_counter",
            J = "f_counter_gate_c",
            k = "f_desk",
            o = "f_habitat_kitchenette",
            W = "f_habitat_storage_board",
            U = "f_habitat_storage_board",
            n = "f_screenmirror",
            q = "f_rack",
            s = "f_sofa",
            v = "f_trashcan",
            l = "f_locker",
            p = "f_indoor_plant",
            e = "f_entertainment_center",
        },
    },
}

-- Life Support furniture items for habbitats which is combinable with other palettes.
ccb.content.define_mapgen_palette {
    id = "afs_habitat_life_support",
    layout = {
        liquid_glyphs = { ["❸"] = { id = "water_clean", amount = { 0, 100 } } },
        furniture = {
            ["❶"] = "f_ECU",
            ["❷"] = "f_air_filter",
            ["❸"] = "f_water_heater",
            ["❹"] = "f_water_purifier",
            ["❺"] = "f_atmospheric_control",
            ["❻"] = "f_cryofluid_pump",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_habitat_heavy_industry_furnishing",
    layout = {
        liquid_glyphs = { W = { id = "water_clean", amount = { 0, 100 } } },
        item_groups = {
            ["%"] = { group = "afs_tools_space_emergency" },
            ["@"] = { group = "bed", chance = 50 },
            k = { group = "SUS_office_desk", chance = 60 },
            l = { group = "afs_frontier_cryo_g", chance = 50 },
            q = {
                { group = "tools_robotics", chance = 5, repetitions = { 2, 5 } },
                { group = "afs_tools_structural_repair", chance = 20, repetitions = { 2, 5 } },
            },
            y = { { group = "afs_tools_electric_repair", chance = 20, repetitions = { 2, 5 } } },
        },
        terrain = { p = "t_sewage_pipe" },
        furniture = {
            ["@"] = "f_bed",
            f = "f_workbench",
            y = "f_workbench",
            c = "f_console_broken",
            h = "f_chair",
            P = "f_water_purifier",
            W = "f_water_heater",
            A = "f_air_filter",
            E = "f_machinery_electronic",
            L = "f_machinery_light",
            H = "f_machinery_heavy",
            O = "f_ECU",
            T = "f_cryofluid_pump",
            l = "f_locker",
            k = "f_desk",
        },
    },
}
