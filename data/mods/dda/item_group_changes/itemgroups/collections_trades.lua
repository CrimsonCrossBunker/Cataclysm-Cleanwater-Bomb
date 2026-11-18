local content = require("ccb").content

do
    -- A general hardware group for retail, workshops, etc.
    local group = content.ItemGroup { id = "hardware", kind = "distribution" }
    group:group("tools_general", 50)
    group:group("supplies_hardware", 50)
    group:group("hardware_clothing", 10)
    group:item("survnote", 1)
    content.add(group)
end

do
    -- A general hardware group for retail, workshops, etc., with an odd assortment of extra items.
    -- often spawns a box to hold everything, sometimes a plastic sheet to cover it, and then some stuff in the box.
    local group = content.ItemGroup { id = "mischw", kind = "collection" }
    group:entry {
        distribution = {
            { item = "box_medium", probability = 75 },
            { item = "box_large", probability = 25 },
        },
        probability = 25,
    }
    group:item("plastic_sheet", 10)
    group:entry {
        distribution = {
            { group = "tools_general", probability = 90 },
            { group = "supplies_hardware", probability = 50 },
            { group = "hardware_clothing", probability = 20 },
            { group = "hardware_bulk", probability = 10 },
            { group = "hardware_books", probability = 10 },
            { item = "survnote", probability = 1 },
            { item = "machete", probability = 5 },
            { item = "boots_combat", probability = 10 },
            { item = "boots_hiking", probability = 5 },
            { item = "runner_bag", probability = 3 },
            { item = "polycarbonate_sheet", probability = 39 },
            { item = "bb", charges = { 1, 500 }, probability = 8 },
            { item = "bbgun", charges = { 0, 150 }, probability = 10 },
            { item = "beartrap", probability = 3 },
            { item = "radio", charges = { 0, 100 }, probability = 20 },
            { item = "hotplate", probability = 10 },
            { item = "extinguisher", charges = { 100, 100 }, probability = 20 },
            { group = "cable_roll", probability = 30 },
            { group = "cable_roll_part", probability = 30 },
            { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 },
            { item = "grapnel", probability = 1 },
            { item = "misc_repairkit", probability = 5 },
            { item = "knitting_needles", probability = 1 },
            { item = "medium_propane_tank", count = { 1, 2 }, charges = { 15000, 15000 }, probability = 20 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mechanics", kind = "distribution", with_ammo = 100 }
    group:group("supplies_spares_vehicle")
    group:group("tools_common")
    group:group("tools_mechanic", 150)
    group:group("supplies_metal", 20)
    group:group("supplies_mechanics", 80)
    group:item("goggles_welding", 50)
    group:item("welding_book", 10)
    group:item("welding_mask", 30)
    group:item("welding_papr_helmet", 10)
    group:item("throat_guard_cut_resistant", 8)
    group:item("jerrycan", 10)
    group:item("jerrycan_big", 10)
    group:item("polycarbonate_sheet", 35)
    group:item("metal_tank", 8)
    group:entry { item = "seatbelt", count = { 1, 4 }, probability = 8 }
    group:entry { item = "five-point_harness", count = { 1, 2 }, probability = 2 }
    group:item("metal_tank_little", 8)
    group:item("55gal_drum_aluminum", 1)
    group:item("30gal_drum_aluminum", 2)
    group:item("cu_pipe", 5)
    group:item("survnote", 1)
    content.upsert_item_group(group)
end
