local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a junk drawer.
    local group = content.ItemGroup { id = "SUS_junk_drawer", kind = "collection" }
    group:item("xacto", 80)
    group:item("scissors", 80)
    group:group("bag_garbage_box_part", 95)
    group:entry { item = "bag_zipper", count = { 1, 18 }, probability = 85 }
    group:entry { item = "bag_zipper_gallon", count = { 1, 9 }, probability = 80 }
    group:item("screwdriver", 70)
    group:item("tape_measure", 20)
    group:item("hammer", 60)
    group:item("pliers", 60)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 75 }
    group:item("hammer", 75)
    group:entry { item = "permanent_marker", charges = { 50, -1 }, probability = 75 }
    group:entry { item = "permanent_marker", charges = { 50, -1 }, probability = 40 }
    group:entry { item = "paper", count = { 5, 20 }, probability = 55 }
    group:group("SUS_used_batteries", 85)
    group:item("battery_charger", 85)
    group:entry { item = "string_36", count = { 1, 4 }, probability = 80 }
    group:entry { item = "string_36", count = { 1, 4 }, probability = 50 }
    group:entry { item = "string_36", count = { 1, 4 }, probability = 20 }
    group:group("duct_tape_roll_part", 40)
    group:group("glue_weak_domestic", 15)
    group:group("glue_strong_domestic", 15)
    group:entry { item = "plastic_straw", count = { 1, 6 }, probability = 70 }
    group:entry { item = "plastic_straw", count = { 1, 6 }, probability = 40 }
    group:item("corkscrew", 60)
    group:item("bottle_opener", 75)
    group:entry { item = "candle", charges = { 10, -1 }, probability = 75 }
    group:group("small_candles_in_box", 50)
    group:item("extension_cable", 45)
    group:item("long_extension_cable", 20)
    group:item("RPG_die", 10)
    group:item("metal_RPG_die", 1)
    group:item("aluminum_foil", 25)
    group:entry { item = "wrapper_foil", count = { 5, 40 }, wrapper = "wrapper_foil_roll", probability = 12 }
    group:entry { item = "nuts_bolts", count = { 1, 4 }, probability = 20 }
    group:entry { item = "plastic_shopping_bag", count = { 1, 10 }, probability = 60 }
    group:entry {
        distribution = {
            { item = "matches", charges = { 1, -1 } },
            { item = "lighter", charges = { 1, -1 } },
            { item = "small_lighter", charges = { 1, -1 } },
            { item = "ref_matches", charges = { 1, -1 } },
        },
        probability = 90,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for an oven that might have some pots and pans in the warming drawer.
    local group = content.ItemGroup { id = "SUS_oven", kind = "collection" }
    group:entry {
        distribution = {
            { item = "extinguisher", charges = { 100, 100 }, probability = 20 },
            { item = "sm_extinguisher", charges = { 10, 10 }, probability = 80 },
        },
        probability = 65,
    }
    group:entry {
        distribution = {
            { item = "pot", probability = 20 },
            {
                item = "tuna_noodle_casserole",
                count = { 4, 4 },
                wrapper = "casserole",
                container = "null",
                probability = 10,
            },
            {
                item = "hot_corn_casserole",
                count = { 4, 4 },
                wrapper = "casserole",
                container = "null",
                probability = 10,
            },
            {
                item = "cheesy_spinach_casserole",
                count = { 4, 4 },
                wrapper = "casserole",
                container = "null",
                probability = 5,
            },
            {
                item = "lazy_lobster_casserole",
                count = { 4, 4 },
                wrapper = "casserole",
                container = "null",
                probability = 2,
            },
            { item = "pot_copper", probability = 5 },
            { item = "iron_pot", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        collection = {
            { item = "pan", count = { 1, 2 }, probability = 60 },
            { item = "steel_pan", count = { 1, 2 }, probability = 50 },
            { item = "copper_pan", count = { 1, 2 }, probability = 30 },
            { item = "dutch_oven", probability = 5 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a cupboard where coffee and tea supplies are kept.
    local group = content.ItemGroup { id = "SUS_coffee_cupboard", kind = "collection" }
    group:entry {
        distribution = {
            { item = "coffeemaker", probability = 90 },
        },
        probability = 75,
    }
    group:entry {
        distribution = {
            { item = "coffee_raw", probability = 30 },
            { item = "instant_coffee", count = { 1, 5 }, probability = 40 },
            { group = "raw_coffee_in_container", probability = 30 },
        },
        probability = 80,
    }
    group:entry { group = "tea_raw_bag_plastic_33", count = { 1, 10 }, probability = 80 }
    group:entry { group = "tea_green_raw_bag_plastic_33", count = { 1, 10 }, probability = 40 }
    group:item("teapot", 70)
    group:item("kettle", 50)
    group:entry { group = "sugar_jar_glass_sealed_10_140", sealed = false, probability = 90 }
    group:entry {
        distribution = {
            {
                item = "milk_powder",
                count = { 5, 20 },
                sealed = false,
                wrapper = "jar_3l_glass_sealed",
                container = "null",
                probability = 60,
            },
            {
                item = "cocoa_powder",
                count = { 5, 20 },
                sealed = false,
                wrapper = "jar_3l_glass_sealed",
                container = "null",
                probability = 60,
            },
            {
                item = "cocoa_powder_milk",
                count = { 5, 20 },
                sealed = false,
                wrapper = "jar_3l_glass_sealed",
                container = "null",
                probability = 60,
            },
            { item = "con_milk", count = { 1, 6 }, probability = 10 },
            { item = "milk_evap", count = { 1, 6 }, probability = 20 },
            { group = "milk_in_container", probability = 10 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "honey_glassed", count = { 1, -1 }, probability = 20 },
            { item = "honey_bottled", charges = { 1, -1 }, probability = 80 },
        },
        probability = 60,
    }
    group:entry { item = "spoon", count = { 1, 6 } }
    group:entry { item = "ceramic_mug", count = { 1, 6 } }
    group:group("teabag_box", 60)
    content.upsert_item_group(group)
end
