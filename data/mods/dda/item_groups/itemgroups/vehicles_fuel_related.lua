local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fuel_jp8", kind = "distribution" }
    group:entry { item = "jp8", charges = { 950, 8000 }, container = "jerrycan", probability = 70 }
    group:entry { item = "jp8", charges = { 3850, 20000 }, container = "jerrycan_big", probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fuel_diesel", kind = "distribution" }
    group:entry { item = "diesel", charges = { 950, 8000 }, container = "jerrycan", probability = 70 }
    group:entry { item = "diesel", charges = { 3850, 20000 }, container = "jerrycan_big", probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fuel_gasoline", kind = "distribution" }
    group:entry { item = "gasoline", charges = { 450, 8000 }, container = "jerrycan", probability = 80 }
    group:entry { item = "gasoline", charges = { 2650, 20000 }, container = "jerrycan_big", probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spare_tire_kit", kind = "collection" }
    group:entry {
        distribution = {
            { item = "wheel", probability = 95 },
            { item = "deflated_wheel", probability = 5 },
        },
        probability = 78,
    }
    group:item("jack", 88)
    group:item("lug_wrench", 92)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spare_tire_kit_wide_wheel", kind = "collection" }
    group:entry {
        distribution = {
            { item = "wheel_wide", probability = 95 },
            { item = "deflated_wheel_wide", probability = 5 },
        },
        probability = 78,
    }
    group:item("jack", 88)
    group:item("lug_wrench", 92)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spare_tire_kit_small_jack", kind = "collection" }
    group:entry {
        distribution = {
            { item = "wheel", probability = 95 },
            { item = "deflated_wheel", probability = 5 },
        },
        probability = 78,
    }
    group:item("jack_small", 88)
    group:item("lug_wrench", 92)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spare_tire_kit_tools_only", kind = "collection" }
    group:item("jack", 88)
    group:item("lug_wrench", 92)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "tools_car_kit",
        kind = "collection",
        container = "toolbox_empty",
        overflow = "discard",
    }
    group:entry {
        distribution = {
            { item = "screwdriver_set" },
            { item = "socket_screwdriver_set" },
            { item = "screwdriver", count = { 1, 3 } },
        },
        probability = 80,
    }
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "pliers_locking" },
                    { item = "big_pliers" },
                    { item = "pliers" },
                },
            },
            {
                distribution = {
                    { item = "wrench" },
                    { item = "wrench_small", count = { 1, 2 } },
                    { item = "wrench_large" },
                    { item = "socket_wrench_set" },
                },
            },
        },
        probability = 80,
    }
    group:group("duct_tape_roll_part", 30)
    group:group("glue_strong_domestic", 20)
    group:entry {
        distribution = {
            { item = "pockknife" },
            { item = "boxcutter" },
        },
        probability = 60,
    }
    group:entry { item = "glowstick", count = { 0, 2 }, charges = { 1400, 1400 }, probability = 30 }
    group:entry {
        distribution = {
            { item = "flashlight", charges = { 0, 100 } },
            { item = "heavy_flashlight", charges = { 0, 100 } },
        },
        probability = 50,
    }
    group:item("multitool", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "car_kit", kind = "collection" }
    group:group("tools_car_kit", 90)
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "jerrycan" },
                    { item = "funnel" },
                },
            },
            {
                collection = {
                    { item = "jerrycan_big" },
                    { item = "funnel" },
                },
            },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "sm_extinguisher", charges = { 10, 10 } },
            { item = "extinguisher", charges = { 100, 100 } },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "used_1st_aid", probability = 70 },
            { group = "full_1st_aid", probability = 30 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { group = "used_survival_kit", probability = 70 },
            { group = "full_survival_kit", probability = 30 },
        },
        probability = 30,
    }
    group:item("plastic_sheet", 12)
    group:item("hd_tow_cable", 5)
    group:item("hose", 50)
    group:item("jumper_cable", 30)
    group:item("hand_pump", 30)
    group:item("folding_solar_panel_v2", 2)
    group:item("tire_repair_kit", 4)
    group:group("bugout_bag", 3)
    group:item("manual_mechanics_car_owner", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "car_misc", kind = "collection" }
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "matches", charges = { 1, 20 } },
                    { item = "ref_matches", charges = { 0, 32 } },
                    { item = "lighter", charges = { 0, 100 } },
                    { item = "small_lighter", charges = { 0, 50 } },
                    { item = "ref_lighter", charges = { 0, 50 } },
                },
            },
            { group = "tobacco_products" },
        },
        probability = 20,
    }
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 10 }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:entry {
        distribution = {
            { item = "umbrella" },
            { item = "teleumbrella" },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { group = "roadmap_stock" },
            { item = "trailmap" },
            { item = "touristmap" },
        },
        probability = 10,
    }
    group:entry {
        distribution = {
            { item = "gasdiscount_silver" },
            { item = "gasdiscount_gold" },
            { item = "gasdiscount_platinum" },
        },
        probability = 10,
    }
    group:entry { group = "snacks_fancy", count = { 1, 2 }, probability = 20 }
    group:group("wallets", 10)
    group:item("sunglasses", 20)
    group:item("knife_swissarmy", 10)
    group:item("folding_solar_panel_v2", 2)
    group:item("thermos", 20)
    group:group("clothing_outdoor_set", 10)
    group:group("entertainment_center_loot", 40)
    group:group("SUS_science_personal_effects", 10)
    group:group("SUS_pantry", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gas_charging_rack", kind = "distribution" }
    group:entry { item = "storage_battery", charges = { 40000, 40000 }, probability = 15 }
    group:entry { item = "storage_battery", charges = { 4000, 10000 }, probability = 40 }
    group:entry { item = "storage_battery", charges = { 0, 2000 }, probability = 60 }
    group:entry { item = "small_storage_battery", charges = { 500, 500 }, probability = 15 }
    group:entry { item = "small_storage_battery", charges = { 0, 200 }, probability = 40 }
    group:entry { item = "medium_storage_battery", charges = { 7000, 7000 }, probability = 15 }
    group:entry { item = "medium_storage_battery", charges = { 0, 2000 }, probability = 40 }
    group:item("it_battery_mount", 90)
    group:item("it_battery_mount", 50)
    group:item("it_battery_mount", 40)
    group:item("it_battery_mount", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wheels", kind = "distribution" }
    group:item("wheel_wood", 25)
    group:item("wheel_metal", 25)
    group:item("wheel_small", 35)
    group:item("wheel_motorbike", 25)
    group:item("wheel_bicycle", 40)
    group:item("wheel_wide_or", 25)
    group:item("wheel_bicycle_or", 25)
    group:item("wheel_motorbike_or", 25)
    group:item("wheel_slick", 25)
    group:item("wheel", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wheels_no_wood", kind = "distribution" }
    group:item("wheel_motorbike", 25)
    group:item("wheel_wide_or", 25)
    group:item("wheel_motorbike_or", 25)
    group:item("wheel_slick", 25)
    group:item("wheel", 50)
    content.add(group)
end
