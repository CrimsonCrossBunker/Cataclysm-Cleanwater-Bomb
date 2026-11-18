local content = require("ccb").content

do
    -- Filler.  Things to keep you going in the dungeon.
    local group = content.ItemGroup { id = "LS_SUS_crate_tier0_supplies", kind = "distribution" }
    -- first aid items based on what would be in an autodoc suite
    group:entry {
        collection = {
            { item = "bandages", count = { 1, 3 }, probability = 40 },
            { item = "liq_bandage_spray", charges = { 1, -1 }, probability = 10 },
            { item = "medical_gauze", count = { 1, 6 }, probability = 40 },
            { item = "disinfectant", probability = 60 },
            { item = "towel", probability = 40 },
            { item = "blood", probability = 40 },
            { group = "bleach_jug_part", probability = 20 },
            { group = "saline_bottle_random", probability = 20 },
            { group = "cotton_ball_bag_used", probability = 50 },
            { item = "chem_nitric_acid", charges = { 1, -1 }, probability = 10 },
            { item = "chem_hydrogen_peroxide_conc", charges = { 1, -1 }, probability = 10 },
            { item = "denat_alcohol", charges = { 250, -1 }, probability = 6 },
            { item = "methed_alcohol", charges = { 250, -1 }, probability = 4 },
            { item = "nl_robo_surg_app", probability = 1 },
            { item = "nl_surg_int_unit", probability = 1 },
        },
    }
    -- edibles based on exodii food.  Will need new definitions.
    group:entry {
        collection = {
            { item = "dry_meat", probability = 20 },
            { item = "dry_fish", probability = 30 },
            { item = "dry_veggy", probability = 40 },
            { item = "dry_corn", probability = 40 },
            { item = "dry_fruit", probability = 30 },
            { item = "salt", probability = 30 },
            { item = "flour", probability = 20 },
            { item = "cornmeal", probability = 25 },
            { item = "oatmeal", probability = 40 },
            { item = "barley", probability = 20 },
        },
    }
    content.add(group)
end

do
    -- Incomplete.  Make tables look interesting.
    local group = content.ItemGroup { id = "LS_SUS_table_items_mess", kind = "distribution" }
    group:item("knife_butter")
    group:item("knife_steak")
    group:item("knife_paring")
    group:item("fork")
    group:item("spoon")
    group:item("bowl_pewter")
    group:item("ceramic_plate")
    group:item("ceramic_bowl")
    group:item("wine_glass")
    group:item("ceramic_mug")
    group:item("pot")
    group:item("bone")
    group:item("kipple_wrapper")
    group:group("LS_SUS_tier0_kipple")
    content.add(group)
end
