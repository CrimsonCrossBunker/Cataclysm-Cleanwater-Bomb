local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for trash in a trashcan, contained in a trashbag
    local group = content.ItemGroup { id = "SUS_trash_trashcan", kind = "distribution" }
    group:group("SUS_trash_trashcan_full", 25)
    group:group("SUS_trash_trashcan_half", 60)
    group:group("SUS_trash_trashcan_empty", 15)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for randomizing between heavy and light amount of trash that you'd find on the floor in a building
    local group = content.ItemGroup { id = "SUS_trash_floor", kind = "distribution" }
    group:group("SUS_trash_floor_light", 75)
    group:group("SUS_trash_floor_heavy", 25)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for small amount of trash on the floor of a building
    local group = content.ItemGroup { id = "SUS_trash_floor_light", kind = "collection" }
    group:entry { group = "SUS_trash_glass", count = { 1, 2 }, probability = 10 }
    -- Containers
    group:entry { item = "wrapper", count = { 1, 2 }, probability = 10 }
    group:entry { item = "wrapper_foil", count = { 1, 2 }, probability = 10 }
    group:item("wrapper_foil_roll", 2)
    group:item("plastic_shopping_bag", 10)
    group:item("bag_plastic", 10)
    group:entry { item = "bag_zipper_gallon", count = { 1, 5 }, probability = 5 }
    group:entry { item = "material_styrofoam_chunk", count = { 1, 2 }, probability = 6 }
    group:item("cup_foil", 5)
    group:entry { item = "cup_plastic", count = { 1, 4 }, probability = 10 }
    group:item("jug_plastic", 5)
    group:entry { item = "bottle_plastic", count = { 1, 3 }, probability = 10 }
    group:entry { item = "bottle_plastic_small", count = { 1, 5 }, probability = 10 }
    group:item("can_drink", 10)
    group:item("can_food", 10)
    group:item("box_small", 10)
    group:entry { group = "pillbox_any_empty", count = { 1, 2 }, probability = 1 }
    group:item("bag_canvas_small", 2)
    group:item("box_snack", 15)
    group:item("box_cigarette", 10)
    group:item("nic_pouch_can", 7)
    group:item("ifak_pouch", 5)
    group:item("bag_paper_powder", 5)
    group:item("bottle_glass_seasoning", 1)
    -- Loose items
    group:item("bubblewrap", 5)
    group:item("lc_wire", 1)
    group:entry { item = "string_6", count = { 1, 2 }, probability = 5 }
    group:item("string_36", 1)
    group:item("scorecard", 5)
    group:item("hairpin", 5)
    group:entry { item = "marble", count = { 1, 5 }, probability = 3 }
    group:entry { item = "matches", charges = { 0, 10 }, probability = 10 }
    group:entry { item = "paper", count = { 1, 20 }, probability = 5 }
    group:item("spring", 15)
    group:entry { item = "plastic_sheet_small", count = { 1, 2 }, probability = 5 }
    group:item("fp_loyalty_card", 5)
    group:item("ceramic_mug", 1)
    group:item("coin_nickel", 1)
    group:item("coin_quarter", 1)
    group:entry { item = "glowstick", charges = { 0, 0 }, probability = 1 }
    group:entry { item = "duct_tape", charges = { 0, 0 }, probability = 1 }
    -- Small trash
    group:entry { item = "splinter", count = { 3, 6 }, probability = 5 }
    group:item("scrap", 5)
    group:entry { item = "ceramic_shard", count = { 1, 2 }, probability = 5 }
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 5,
    }
    group:entry { item = "cig_butt", count = { 1, 5 }, probability = 10 }
    -- Lore items
    group:group("SUS_book_nonf_zine_news", 5)
    group:item("flyer", 5)
    group:item("flyer_evac", 10)
    group:item("survnote", 1)
    group:item("godco_flier", 1)
    content.upsert_item_group(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for large amount of trash on the floor of a building
    local group = content.ItemGroup { id = "SUS_trash_floor_heavy", kind = "collection" }
    group:entry { group = "SUS_trash_glass", count = { 1, 2 }, probability = 10 }
    -- Containers
    group:entry { item = "wrapper", count = { 1, 2 }, probability = 30 }
    group:entry { item = "wrapper_foil", count = { 1, 2 }, probability = 30 }
    group:item("wrapper_foil_roll", 10)
    group:item("plastic_shopping_bag", 30)
    group:item("bag_plastic", 30)
    group:item("bag_zipper_gallon", 20)
    group:entry { item = "material_styrofoam_chunk", count = { 1, 6 }, probability = 2 }
    group:entry { item = "cup_foil", count = { 1, 3 }, probability = 30 }
    group:entry { item = "cup_plastic", count = { 1, 3 }, probability = 30 }
    group:item("jug_plastic", 20)
    group:entry { item = "bottle_glass", count = { 1, 3 }, probability = 10 }
    group:entry { item = "bottle_plastic", count = { 1, 2 }, probability = 30 }
    group:entry { item = "bottle_plastic_small", count = { 1, 2 }, probability = 35 }
    group:item("can_drink", 30)
    group:item("can_food", 30)
    group:item("box_small", 30)
    group:entry { group = "pillbox_any_empty", count = { 1, 3 }, probability = 10 }
    group:item("bag_canvas_small", 10)
    group:item("box_snack", 25)
    group:item("box_cigarette", 10)
    group:item("nic_pouch_can", 10)
    group:item("ifak_pouch", 15)
    group:item("bag_paper_powder", 15)
    group:item("bottle_glass_seasoning", 5)
    -- Loose items
    group:item("bubblewrap", 15)
    group:entry { item = "lc_wire", count = { 1, 4 }, probability = 10 }
    group:entry { item = "string_6", count = { 1, 5 }, probability = 20 }
    group:entry { item = "string_36", count = { 1, 3 }, probability = 10 }
    group:item("scorecard", 20)
    group:item("hairpin", 20)
    group:entry { item = "marble", count = { 5, 20 }, probability = 5 }
    group:entry { item = "matches", charges = { 0, 10 }, probability = 20 }
    group:entry { item = "paper", count = { 5, 50 }, probability = 20 }
    group:item("spring", 20)
    group:group("tinware", 5)
    group:entry { item = "plastic_sheet", count = { 1, 4 }, probability = 10 }
    group:entry { item = "plastic_sheet_small", count = { 3, 8 }, probability = 15 }
    group:item("fp_loyalty_card", 15)
    group:item("mask_dust", 2)
    group:item("coin_nickel", 1)
    group:item("coin_quarter", 1)
    group:entry { item = "glowstick", charges = { 0, 0 }, probability = 5 }
    group:entry { item = "duct_tape", charges = { 0, 0 }, probability = 5 }
    -- Small trash
    group:entry { item = "splinter", count = { 5, 20 }, probability = 20 }
    group:entry { item = "scrap", count = { 1, 2 }, probability = 20 }
    group:entry { item = "ceramic_shard", count = { 2, 4 }, probability = 20 }
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 20,
    }
    group:entry { item = "cig_butt", count = { 3, 6 }, probability = 20 }
    -- Lore items
    group:group("SUS_book_nonf_zine_news", 20)
    group:entry { item = "flyer", count = { 1, 3 }, probability = 20 }
    group:entry { item = "flyer_evac", count = { 1, 3 }, probability = 20 }
    content.upsert_item_group(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for forests without manmade trash
    local group = content.ItemGroup { id = "SUS_trash_forest_no_manmade", kind = "collection" }
    group:entry { item = "twig", count = { 1, 10 }, probability = 20 }
    group:entry { item = "rock", count = { 1, 4 }, probability = 20 }
    group:item("rock_flaking", 10)
    group:item("flint", 2)
    group:item("stick", 10)
    group:item("acorns", 5)
    group:item("pinecone", 5)
    group:entry { item = "withered", count = { 1, 5 }, probability = 10 }
    group:entry { item = "plant_fibre", count = { 1, 5 }, probability = 20 }
    group:item("straw_pile", 10)
    group:item("tanbark", 5)
    group:item("rock_large", 10)
    group:item("field_stone", 5)
    group:item("pine_bough", 5)
    group:entry { item = "splinter", count = { 1, 5 }, probability = 10 }
    group:item("hickory_root", 5)
    group:item("hickory_nut", 5)
    group:item("tinder", 10)
    group:entry { item = "feather", count = { 1, 3 }, probability = 2 }
    group:item("bone", 1)
    group:item("log", 3)
    group:entry { item = "pebble", count = { 1, 10 }, probability = 10 }
    content.add(group)
end
