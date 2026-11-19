local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "hollow_village_palette",
    layout = {
        sealed_item_glyphs = {
            ["%"] = { item = { id = "seed_oats" }, furniture = "f_plant_seedling", chance = 96 },
            ["♣"] = { item = { id = "seed_carrot" }, furniture = "f_plant_seedling", chance = 70 },
            ["Ʌ"] = { item = { id = "seed_zucchini" }, furniture = "f_plant_seedling", chance = 70 },
        },
        item_groups = {
            ["+"] = {
                { group = "hollow_village_farm_tools", chance = 80, repetitions = { 3, 4 } },
                { group = "hollow_village_farming_seeds", chance = 80, repetitions = { 3, 4 } },
            },
            ["="] = { group = "hollow_village_storage", chance = 70, repetitions = { 1, 3 } },
            U = { group = "hollow_village_foodstuffs", repetitions = { 1, 2 }, chance = 80 },
        },
        terrain = {
            ["3"] = "t_door_makeshift_c",
            ["1"] = "t_palisade",
            ["!"] = "t_pit_spiked",
            ["-"] = "t_wall_log",
            ["|"] = "t_wall_log",
            ["#"] = "t_dirtfloor_thatchroof",
            o = "t_dirtfloor_thatchroof",
            B = "t_dirtfloor_thatchroof",
            ["="] = "t_dirtfloor_thatchroof",
            ["+"] = "t_dirtfloor_thatchroof",
            I = "t_drystone_wall_half",
            W = "t_wooden_well",
            ["."] = { { id = "t_grass", copies = 85 }, { id = "t_dirt", copies = 15 } },
            [","] = { { id = "t_region_soil", copies = 95 }, { id = "t_grass", copies = 5 } },
            _ = "t_dirt",
            U = "t_dirt",
            ["%"] = { { id = "t_dirtmound", copies = 98 }, { id = "t_region_soil", copies = 2 } },
            ["Ʌ"] = { { id = "t_dirtmound", copies = 98 }, { id = "t_region_soil", copies = 2 } },
            ["♣"] = { { id = "t_dirtmound", copies = 98 }, { id = "t_region_soil", copies = 2 } },
        },
        furniture = {
            t = "f_logstool",
            o = "f_firering",
            O = "f_firering",
            ["="] = "f_rack_primitive",
            ["+"] = "f_rack_primitive",
            H = "f_smoking_rack",
            B = "f_hammock",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "hollow_village_palette_zombed",
    layout = {
        sealed_item_glyphs = {
            ["%"] = { item = { id = "seed_oats" }, furniture = "f_plant_seedling", chance = 30 },
            ["♣"] = { item = { id = "seed_carrot" }, furniture = "f_plant_seedling", chance = 30 },
            ["Ʌ"] = { item = { id = "seed_zucchini" }, furniture = "f_plant_seedling", chance = 30 },
        },
        item_groups = {
            ["+"] = {
                { group = "hollow_village_farm_tools", chance = 50, repetitions = { 3, 4 } },
                { group = "hollow_village_farming_seeds", chance = 50, repetitions = { 3, 4 } },
            },
            ["="] = { group = "hollow_village_storage", chance = 70, repetitions = { 1, 3 } },
            U = { group = "hollow_village_foodstuffs", repetitions = { 1, 2 }, chance = 30 },
        },
        terrain = {
            ["3"] = "t_door_makeshift_c",
            ["1"] = { { id = "t_palisade", copies = 60 }, { id = "t_wall_log_broken", copies = 40 } },
            ["!"] = "t_pit_spiked",
            ["-"] = { { id = "t_wall_log", copies = 70 }, { id = "t_wall_log_broken", copies = 30 } },
            ["|"] = { { id = "t_wall_log", copies = 70 }, { id = "t_wall_log_broken", copies = 30 } },
            ["#"] = "t_dirtfloor_thatchroof",
            o = "t_dirtfloor_thatchroof",
            B = "t_dirtfloor_thatchroof",
            ["="] = "t_dirtfloor_thatchroof",
            I = "t_drystone_wall_half",
            W = "t_wooden_well",
            ["."] = "t_grass",
            [","] = { { id = "t_region_soil", copies = 75 }, { id = "t_grass", copies = 25 } },
            _ = "t_dirt",
            ["%"] = { { id = "t_dirtmound", copies = 50 }, { id = "t_region_soil", copies = 50 } },
            ["Ʌ"] = { { id = "t_dirtmound", copies = 50 }, { id = "t_region_soil", copies = 50 } },
            ["♣"] = { { id = "t_dirtmound", copies = 50 }, { id = "t_region_soil", copies = 50 } },
        },
        furniture = {
            t = "f_logstool",
            o = "f_firering",
            O = "f_firering",
            ["="] = "f_rack_primitive",
            ["+"] = "f_rack_primitive",
            H = "f_smoking_rack",
            B = "f_hammock",
        },
    },
}
