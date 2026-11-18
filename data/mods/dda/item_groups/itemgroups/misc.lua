local content = require("ccb").content

do
    -- Smokable item and something to light it with
    local group = content.ItemGroup { id = "misc_smoking", kind = "collection" }
    group:entry {
        distribution = {
            { group = "cigarettes_opened", wrapper = "box_cigarette", probability = 70 },
            {
                collection = {
                    { item = "tobacco", count = { 1, 20 }, wrapper = "bag_plastic", container = "null" },
                    {
                        distribution = {
                            { item = "rolling_paper", charges = { 1, 30 }, probability = 70 },
                            { item = "pipe_tobacco", probability = 30 },
                        },
                    },
                },
                probability = 20,
            },
            { item = "cigar", count = { 1, 1 }, probability = 5 },
            { item = "joint", probability = 5 },
        },
    }
    group:entry {
        distribution = {
            { item = "lighter", charges = { 0, 100 } },
            { item = "matches", charges = { 1, 20 } },
            { item = "ref_matches", charges = { 1, 32 } },
        },
    }
    content.add(group)
end

do
    -- Processed weed and weed accessories
    local group = content.ItemGroup { id = "stoner", kind = "distribution" }
    group:item("joint")
    group:item("joint_roach", 20)
    group:item("pipe_glass", 10)
    group:item("pipe_water", 10)
    content.add(group)
end

do
    -- Used for shop spawns where unused cans of butane are stocked
    local group = content.ItemGroup { id = "butane_lighter_and_fuel", kind = "distribution" }
    group:entry {
        collection = {
            { item = "ref_lighter_butane" },
            { item = "butane_can", count = { 1, 2 }, charges = { 400, 400 } },
        },
    }
    content.add(group)
end

do
    -- Used for shop spawns where unused cans of butane are stocked
    local group = content.ItemGroup { id = "butane_can_full", kind = "distribution" }
    group:entry { item = "butane_can", count = { 1, 2 }, charges = { 400, 400 } }
    content.add(group)
end

do
    -- Forks, spoons, knives, etc.
    local group = content.ItemGroup { id = "silverware", kind = "distribution" }
    group:item("knife_butter", 30)
    group:item("knife_small", 10, "knife_steak")
    group:item("fork", 30)
    group:item("spoon", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_toy_box", kind = "collection", container = "rc_car_box" }
    group:entry { item = "bubblewrap", count = { 0, 2 } }
    group:item("screwdriver", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tinware", kind = "distribution" }
    group:item("bowl_pewter")
    group:item("tin_plate")
    group:item("tin_cup")
    content.add(group)
end

do
    -- Plates, bowls, cups, etc.
    local group = content.ItemGroup { id = "dinnerware", kind = "distribution" }
    group:item("glass", 20)
    group:item("glass_plate", 20)
    group:item("glass_bowl", 20)
    group:item("ceramic_plate", 10)
    group:item("wine_glass", 10)
    group:item("ceramic_bowl", 10)
    group:item("ceramic_cup", 10)
    content.add(group)
end

do
    -- Intended to comprise about 50L of material
    local group = content.ItemGroup { id = "digging_sand_50L", kind = "collection" }
    group:entry { item = "material_soil", count = { 0, 1 } }
    group:entry { item = "material_sand", count = { 6000, 7000 } }
    group:entry { item = "clay_lump", count = { 10, 16 } }
    group:entry { item = "rock", count = { 0, 4 } }
    group:entry { item = "pebble", count = { 10, 50 } }
    content.add(group)
end

do
    -- Intended to comprise about 50L of material
    local group = content.ItemGroup { id = "digging_clay_50L", kind = "collection" }
    group:entry { item = "material_soil", count = { 2, 4 } }
    group:entry { item = "clay_lump", count = { 30, 80 } }
    group:entry { item = "rock", count = { 0, 4 } }
    group:entry { item = "pebble", count = { 5, 25 } }
    content.add(group)
end

do
    -- Intended to comprise about 50L of material. Artificial, man-made gravel of varying size.
    local group = content.ItemGroup { id = "digging_gravel_50L", kind = "collection" }
    group:entry { item = "material_soil", count = { 0, 1 } }
    group:entry { item = "pebble", count = { 150, 200 } }
    group:entry { item = "material_gravel", count = { 4000, 4500 } }
    content.add(group)
end

do
    -- ~50L of loamy soil, sand, clay, and rocks from digging in generic dirt
    local group = content.ItemGroup { id = "digging_soil_loam_50L", kind = "collection" }
    group:entry { item = "material_soil", count = { 8, 12 } }
    group:entry { item = "material_sand", charges = { 1, 10 }, probability = 5 }
    group:entry { item = "clay_lump", count = { 1, 4 }, probability = 5 }
    group:entry { item = "rock", count = { 1, 4 }, probability = 10 }
    group:entry { item = "rock_flaking", count = { 1, 4 }, probability = 2 }
    group:item("flint", 1)
    group:item("material_limestone", 1)
    group:item("rock_large", 10)
    group:entry { item = "field_stone", count = { 1, 4 }, probability = 10 }
    group:entry { item = "pebble", count = { 1, 4 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "digging_topsoil_loam_50L", kind = "collection" }
    group:entry { group = "digging_soil_loam_50L", count = { 1, 1 } }
    group:entry { item = "earthworm", count = { 0, 10 }, probability = 75 }
    group:entry { item = "earthworm_handful", count = { 0, 3 }, probability = 60 }
    group:entry { item = "earthworm_handful", count = { 1, 2 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mining_rock", kind = "collection" }
    group:entry { item = "pebble", count = { 50, 100 } }
    group:entry { item = "rock", count = { 200, 250 } }
    group:entry { item = "rock_large", count = { 240, 260 } }
    group:entry { item = "coal_lump", charges = { 2500, 5000 }, probability = 10 }
    group:entry { item = "material_shrd_limestone", count = { 10, 25 }, probability = 70 }
    group:entry { item = "material_rocksalt", count = { 0, 1 }, probability = 20 }
    group:entry { item = "material_rhodonite", count = { 0, 1 }, probability = 3 }
    group:entry { item = "material_zincite", count = { 0, 5 }, probability = 5 }
    group:entry { item = "chunk_feldspar", count = { 10, 25 }, probability = 50 }
    group:entry { item = "chunk_graphite", count = { 0, 2 }, probability = 2 }
    group:entry { item = "chunk_caco3", count = { 0, 2 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bus_common", kind = "collection" }
    group:group("child_items", 15)
    group:group("jackets", 15)
    group:group("novels", 15)
    group:group("bags_trip", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "premium_contents", kind = "collection", container = "large_survival_kit_box" }
    group:item("knife_folding")
    group:item("flint_steel")
    group:item("whistle_multitool")
    group:item("bottle_folding")
    group:entry { item = "flashlight", charges = { 150, 150 } }
    group:item("picklocks")
    group:item("lifestraw")
    group:item("pocket_survival")
    group:entry { item = "handflare", count = { 4, 4 }, charges = { 300, 300 } }
    content.add(group)
end

do
    -- Horse vehicle items
    local group = content.ItemGroup { id = "horse_gear", kind = "distribution" }
    group:item("horse_tack", 50)
    group:item("horse_stirrups", 35)
    group:item("yoke_harness", 50)
    group:item("reins_tackle", 50)
    group:item("saddlebag", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "riding_gear", kind = "distribution" }
    group:item("helmet_riding", 50)
    group:item("helmet_riding_peakless", 20)
    group:item("dressage_whip", 20)
    group:item("riding_crop", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spiral", kind = "distribution" }
    group:item("spiral_stone", 20)
    group:item("vortex_stone", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cathedral_archives", kind = "collection" }
    group:entry { item = "book_binder", count = { 1, 5 }, charges = { 0, 90 }, probability = 90 }
    group:entry { item = "file", count = { 1, 15 }, probability = 50 }
    group:entry { item = "paper", count = { 10, 125 }, probability = 60 }
    group:item("book_pieces", 20)
    group:entry { item = "candle", charges = { 100, 100 }, probability = 3 }
    group:item("holybook_bible1", 3)
    group:item("candlestick", 2)
    group:item("chalice", 1)
    group:item("book_ruined", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "pencil_case_with_contents",
        kind = "collection",
        container = "pencil_case",
        overflow = "spill",
    }
    group:group("pencil_case_contents")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pencil_case_contents", kind = "collection" }
    group:group("pens", 90)
    group:group("pens", 30)
    group:item("pencil", 30)
    group:item("scissors_child", 50)
    group:item("eraser", 50)
    group:item("sharpener", 50)
    group:item("ruler", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pillbox_any_empty", kind = "distribution" }
    group:item("pillbox")
    group:item("pillbox_large")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "armor_riot", kind = "distribution" }
    group:item("armor_riot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "helmet_riot", kind = "distribution" }
    group:item("helmet_riot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "armor_riot_arm", kind = "distribution" }
    group:item("armor_riot_arm")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "armor_riot_leg", kind = "distribution" }
    group:item("armor_riot_leg")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "butterfly_net_any", kind = "distribution" }
    group:item("butterfly_net_collapsible", 4)
    group:item("butterfly_net_makeshift", 6)
    content.add(group)
end

do
    -- Any reptile eggs that make sense to find in random underbrush, assuming that it's a fair distance away from water.
    local group = content.ItemGroup { id = "egg_reptile_forest", kind = "distribution" }
    group:item("egg_turtle_painted", 5)
    group:item("egg_wormsnake", 2)
    group:item("egg_skink_fivelined", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sex_accessories_domestic", kind = "distribution" }
    group:entry {
        distribution = {
            {
                distribution = {
                    { item = "sextoy", variant = "beads" },
                    { item = "sextoy", variant = "plug" },
                },
                probability = 46,
            },
            {
                distribution = {
                    { item = "rope_6" },
                    { item = "bullwhip" },
                    { item = "candle" },
                    { item = "handcuffs_leather" },
                    { item = "gag_ball" },
                    { item = "paddle_plastic" },
                },
                probability = 27,
            },
            { item = "sextoy", variant = "dildo", probability = 35 },
            {
                distribution = {
                    { item = "moisturizer", count = { 8, 8 }, variant = "lube", wrapper = "bottle_plastic_small" },
                },
                probability = 40,
            },
            { item = "vibrator", charges = { 0, 100 }, variant = "egg", probability = 29 },
            {
                distribution = {
                    { item = "vibrator", charges = { 0, 100 }, variant = "wand", probability = 30 },
                    { item = "vibrator", charges = { 0, 100 }, variant = "dildo", probability = 60 },
                },
                probability = 55,
            },
        },
        probability = 90,
    }
    group:item("condom", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "decks_of_cards", kind = "distribution" }
    group:item("deck_of_cards", 10)
    group:item("deck_of_tarot_cards", 1)
    content.add(group)
end
