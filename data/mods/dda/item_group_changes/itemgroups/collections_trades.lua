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
