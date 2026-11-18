local content = require("ccb").content

do
    local group = content.ItemGroup { id = "trash_junkyard", kind = "distribution" }
    group:item("scrap", 50)
    group:item("lc_steel_lump", 30)
    group:item("lc_steel_chunk", 30)
    group:item("chain", 10)
    group:item("spring", 10)
    group:item("hose", 10)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for a low amount of trash in a trashcan, contained in a trashbag
    local group = content.ItemGroup {
        id = "SUS_trash_trashcan_empty",
        kind = "collection",
        container = "bag_garbage",
        overflow = "spill",
    }
    group:entry { group = "SUS_trash_floor", count = { 0, 1 }, probability = 75 }
    group:item("joint_roach", 1)
    group:entry { item = "material_styrofoam_chunk", count = { 1, 2 }, probability = 1 }
    group:entry { item = "lighter", charges = { 0, 10 }, probability = 5 }
    group:entry { item = "matches", charges = { 0, 3 }, probability = 5 }
    group:item("news_regional", 8)
    group:group("newspaper", 10)
    group:item("file", 5)
    group:item("handflare_dead", 1)
    group:entry { item = "creepy_doll", charges = { 0, 10 }, probability = 1 }
    group:item("razor_blade", 2)
    group:item("survnote", 1)
    group:entry { item = "inhaler", charges = { 0, 2 }, probability = 1 }
    group:entry { item = "light_battery_cell", count = { 1, 4 }, charges = { 0, 100 }, probability = 1 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for metal trash, for use in other item groups or around metalworking areas
    local group = content.ItemGroup { id = "SUS_trash_metal", kind = "collection" }
    group:item("lc_wire", 5)
    group:item("mc_wire", 5)
    group:item("hc_wire", 5)
    group:item("ch_wire", 3)
    group:item("qt_wire", 3)
    group:item("sheet_metal_small", 2)
    group:item("pipe", 5)
    group:entry { item = "nuts_bolts", count = { 1, 15 }, probability = 10 }
    group:entry { item = "scrap", count = { 1, 2 }, probability = 5 }
    group:item("scrap_bronze", 2)
    group:item("scrap_brass", 2)
    group:item("scrap_tin", 4)
    group:item("scrap_aluminum", 4)
    group:item("scrap_cast_iron", 2)
    group:group("tools_general", 2)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for wooden trash, for use in other item groups or around woodworking areas
    local group = content.ItemGroup { id = "SUS_trash_wood", kind = "collection" }
    group:group("tools_general", 2)
    group:entry { item = "nail", charges = { 1, 15 }, probability = 10 }
    group:entry { item = "nuts_bolts", count = { 1, 15 }, probability = 5 }
    group:entry { item = "splinter", count = { 4, 20 }, probability = 10 }
    group:entry { item = "wood_block", count = { 1, 5 }, probability = 5 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for electrical trash, for use in other item groups or power infrastructure / workbenches
    local group = content.ItemGroup { id = "SUS_trash_electrical", kind = "collection" }
    group:group("tools_general", 2)
    group:entry { item = "e_scrap", count = { 0, 4 }, probability = 15 }
    group:entry { item = "copper_wire", count = { 0, 10 }, probability = 5 }
    group:entry { item = "solder_wire", charges = { 0, 10 }, probability = 10 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for hardware trash
    local group = content.ItemGroup { id = "SUS_trash_hardware", kind = "collection" }
    group:group("SUS_trash_metal", 30)
    group:group("SUS_trash_wood", 30)
    group:group("SUS_trash_electrical", 30)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for sewing trash
    local group = content.ItemGroup { id = "SUS_trash_sewing", kind = "collection" }
    group:entry { item = "button_plastic", charges = { 4, 20 }, probability = 20 }
    group:entry { item = "thread", charges = { 2, 7 }, probability = 5 }
    group:entry { item = "thread_nomex", charges = { 1, 2 }, probability = 2 }
    group:entry { item = "thread_kevlar", charges = { 1, 3 }, probability = 2 }
    group:entry { item = "thread_canvas", charges = { 1, 4 }, probability = 3 }
    group:entry { item = "cotton_patchwork", count = { 1, 2 }, probability = 5 }
    group:entry { item = "sheet_cotton", count = { 1, 2 }, probability = 4 }
    group:item("sheet_felt", 2)
    group:item("sheet_canvas", 2)
    group:item("sheet_lycra", 3)
    group:item("sheet_nylon", 2)
    group:item("sheet_nomex", 4)
    group:item("sheet_kevlar", 4)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for curbside trashcans, contained within multiple garbage bags
    local group = content.ItemGroup { id = "SUS_trash_rolling_trashcan", kind = "collection" }
    group:entry { group = "SUS_trash_trashcan_full", count = { 0, 4 } }
    group:entry { item = "box_small_folded", count = { 0, 2 }, probability = 20 }
    group:entry { item = "box_medium_folded", count = { 0, 1 }, probability = 10 }
    group:entry { item = "box_large_folded", count = { 0, 1 }, probability = 15 }
    group:entry { item = "box_oversize_folded", count = { 0, 1 }, probability = 5 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for dumpsters, contained within multiple garbage bags
    local group = content.ItemGroup { id = "SUS_trash_dumpster", kind = "collection" }
    group:entry { group = "SUS_trash_trashcan_full", count = { 0, 8 } }
    group:entry { item = "box_small", count = { 0, 5 }, probability = 20 }
    group:entry { item = "box_medium", count = { 0, 4 }, probability = 10 }
    group:entry { item = "box_large", count = { 0, 4 }, probability = 15 }
    group:entry { item = "box_oversize", count = { 0, 2 }, probability = 5 }
    group:entry { item = "box_small_folded", count = { 0, 5 }, probability = 20 }
    group:entry { item = "box_medium_folded", count = { 0, 4 }, probability = 10 }
    group:entry { item = "box_large_folded", count = { 0, 4 }, probability = 15 }
    group:entry { item = "box_oversize_folded", count = { 0, 2 }, probability = 5 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for trashcans that are in public, contained in a trash bag
    local group = content.ItemGroup { id = "SUS_trash_trashcan_public", kind = "collection", container = "bag_garbage" }
    group:entry { item = "wrapper", count = { 2, 15 }, probability = 40 }
    group:entry { item = "wrapper_foil", count = { 2, 15 }, probability = 30 }
    group:entry { item = "wrapper_foil_roll", count = { 1, 6 }, probability = 5 }
    group:entry { item = "material_styrofoam_chunk", count = { 1, 3 }, probability = 2 }
    group:entry { item = "bag_plastic", count = { 1, 6 }, probability = 15 }
    group:entry { item = "bottle_glass", count = { 2, 5 }, probability = 10 }
    group:entry { item = "can_drink", count = { 2, 7 }, probability = 10 }
    group:entry { item = "news_regional", count = { 1, 4 }, probability = 20 }
    group:entry { item = "mag_news", count = { 1, 3 }, probability = 20 }
    group:entry { item = "flyer", count = { 2, 10 }, probability = 10 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for trash you might find on a roof
    local group = content.ItemGroup { id = "SUS_trash_roof", kind = "collection", with_ammo = 20, with_magazine = 50 }
    group:entry { group = "SUS_trash_floor", count = { 0, 4 }, probability = 20 }
    group:item("chain", 4)
    group:item("joint_roach", 5)
    group:item("pipe", 2)
    group:item("syringe", 8)
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "efiles_contraband" },
        },
        probability = 5,
    }
    group:entry { item = "spray_can", charges = { 0, 4 }, probability = 10 }
    group:entry { item = "creepy_doll", charges = { 0, 2 }, probability = 1 }
    group:item("razor_blade", 2)
    group:item("survnote", 5)
    group:item("eclipse_glasses", 1)
    group:item("thermos", 10)
    group:item("frisbee", 5)
    group:item("disc_golf", 5)
    group:item("lawn_dart", 5)
    group:item("golf_ball", 5)
    group:entry { group = "alcohol_bottled_canned", count = { 1, 4 }, probability = 20 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for glass trash
    local group = content.ItemGroup { id = "SUS_trash_glass", kind = "distribution" }
    group:entry { item = "glass_shard", count = { 4, 20 }, probability = 10 }
    group:entry { item = "bottle_glass", count = { 1, 2 }, probability = 2 }
    group:item("jar_glass_sealed", 2)
    group:item("jar_3l_glass_sealed", 1)
    content.add(group)
end

do
    -- Trash that's often found on the side of the highway.
    local group = content.ItemGroup { id = "SUS_trash_highway_shoulder", kind = "distribution" }
    group:group("SUS_trash_forest_manmade", 50)
    group:group("SUS_trash_glass", 15)
    group:item("rubber_tire_chunk", 200)
    group:group("SUS_trash_trashcan", 5)
    group:item("plastic_chunk", 50)
    group:group("SUS_trash_floor", 50)
    group:item("cardboard", 25)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for an almost full trashbag in a trashcan
    local group = content.ItemGroup {
        id = "SUS_trash_trashcan_full",
        kind = "collection",
        container = "bag_garbage",
        overflow = "spill",
    }
    group:entry { group = "SUS_trash_floor", count = { 4, 12 }, probability = 75 }
    group:entry { group = "SUS_trash_hardware", count = { 1, 5 }, probability = 20 }
    group:entry { group = "SUS_trash_sewing", count = { 1, 2 }, probability = 10 }
    group:group("civilian_memory_cards", 6)
    group:entry { item = "material_styrofoam_chunk", count = { 1, 5 }, probability = 2 }
    group:item("bum_wine", 5)
    group:entry { item = "chain", count = { 1, 5 }, probability = 10 }
    group:item("glass_sheet", 5)
    group:entry { item = "joint_roach", count = { 0, 5 }, probability = 5 }
    group:item("ceramic_mug", 1, "mean_mug")
    group:item("ceramic_mug", 1, "mean_mug2")
    group:entry { item = "lighter", charges = { 0, 10 }, probability = 20 }
    group:entry { item = "matches", charges = { 0, 3 }, probability = 20 }
    group:item("syringe", 5)
    group:entry { group = "silverware", count = { 2, 6 }, probability = 5 }
    group:entry { item = "leather", count = { 2, 8 }, probability = 5 }
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "efiles_scrap" },
        },
        probability = 10,
    }
    group:entry { item = "news_regional", count = { 2, 5 }, probability = 30 }
    group:entry { group = "newspaper", count = { 2, 5 }, probability = 20 }
    group:entry { item = "file", count = { 1, 4 }, probability = 5 }
    group:item("decoy_elfa", 10)
    group:item("fuel_tin", 8)
    group:item("spray_can", 2)
    group:item("jar_glass_sealed", 10)
    group:item("jar_3l_glass_sealed", 8)
    group:item("handflare_dead", 3)
    group:entry { item = "creepy_doll", charges = { 0, 2 }, probability = 1 }
    group:group("SUS_book_nonf_pulp_newage", 2)
    group:item("razor_blade", 10)
    group:item("survnote", 5)
    group:entry { item = "balloon", count = { 5, 10 }, probability = 5 }
    group:item("box_medium_folded", 15)
    group:entry { item = "inhaler", charges = { 0, 2 }, probability = 5 }
    group:entry { item = "light_minus_disposable_cell", charges = { 0, 0 }, probability = 2 }
    group:entry { item = "light_battery_cell", count = { 1, 4 }, charges = { 0, 2 }, probability = 5 }
    group:entry { item = "ear_plugs", count = { 2, 2 }, probability = 20 }
    group:item("book_ruined", 5)
    group:entry { item = "candle", count = { 1, 2 }, charges = { 0, 8 }, probability = 33 }
    group:item("family_photo", 2)
    group:item("eraser", 5)
    group:entry {
        item = "cotton_ball",
        count = { 3, 7 },
        flags = {
            "FILTHY",
        },
        probability = 10,
    }
    group:group("used_toy_box", 8)
    group:entry { group = "superglue_bottles", count = { 1, 3 }, probability = 8 }
    group:item("godco_flier", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given spot.
    -- This group is for a normal amount of trash in a trashcan, contained in a trashbag
    local group = content.ItemGroup {
        id = "SUS_trash_trashcan_half",
        kind = "collection",
        container = "bag_garbage",
        overflow = "spill",
    }
    group:entry { group = "SUS_trash_floor", count = { 1, 5 }, probability = 75 }
    group:entry { group = "SUS_trash_hardware", count = { 0, 2 }, probability = 20 }
    group:group("SUS_trash_sewing", 10)
    group:group("civilian_memory_cards", 6)
    group:entry { item = "material_styrofoam_chunk", count = { 1, 3 }, probability = 2 }
    group:item("bum_wine", 5)
    group:entry { item = "chain", count = { 1, 2 }, probability = 10 }
    group:item("glass_sheet", 5)
    group:entry { item = "joint_roach", count = { 0, 2 }, probability = 5 }
    group:item("ceramic_mug", 1, "mean_mug")
    group:item("ceramic_mug", 1, "mean_mug2")
    group:entry { item = "lighter", charges = { 0, 10 }, probability = 10 }
    group:entry { item = "matches", charges = { 0, 3 }, probability = 10 }
    group:item("syringe", 2)
    group:entry { group = "silverware", count = { 1, 2 }, probability = 2 }
    group:entry { item = "leather", count = { 2, 3 }, probability = 5 }
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "efiles_scrap" },
        },
        probability = 10,
    }
    group:entry { item = "news_regional", count = { 1, 3 }, probability = 20 }
    group:entry { group = "newspaper", count = { 1, 2 }, probability = 20 }
    group:item("file", 5)
    group:item("decoy_elfa", 5)
    group:item("fuel_tin", 4)
    group:item("spray_can", 2)
    group:item("jar_glass_sealed", 5)
    group:item("jar_3l_glass_sealed", 4)
    group:item("handflare_dead", 3)
    group:entry { item = "creepy_doll", charges = { 0, 2 }, probability = 1 }
    group:group("SUS_book_nonf_pulp_newage", 1)
    group:item("razor_blade", 5)
    group:item("survnote", 5)
    group:item("box_medium_folded", 15)
    group:entry { item = "inhaler", charges = { 0, 2 }, probability = 5 }
    group:entry { item = "light_minus_disposable_cell", charges = { 0, 0 }, probability = 2 }
    group:entry { item = "light_battery_cell", count = { 1, 4 }, charges = { 0, 2 }, probability = 5 }
    group:entry { item = "ear_plugs", count = { 2, 2 }, probability = 10 }
    group:item("book_ruined", 5)
    group:entry { item = "candle", count = { 1, 2 }, charges = { 0, 8 }, probability = 10 }
    group:entry {
        item = "cotton_ball",
        count = { 3, 7 },
        flags = {
            "FILTHY",
        },
        probability = 5,
    }
    group:group("used_toy_box", 8)
    group:group("superglue_bottles", 8)
    group:entry { item = "godco_flier", count = { 1, 3 }, probability = 1 }
    content.add(group)
end
