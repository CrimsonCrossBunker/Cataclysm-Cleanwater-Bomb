local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a storage furniture containing supplies for an office.
    local group = content.ItemGroup { id = "SUS_office_supplies", kind = "collection" }
    group:entry {
        group = "used_eink_tablet_pcs",
        count = { 1, 2 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 30,
    }
    group:entry {
        group = "used_laptops",
        count = { 1, 4 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:entry {
        group = "used_usb_drives",
        count = { 3, 8 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:entry {
        group = "used_memory_cards",
        count = { 2, 7 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:item("battery_charger", 80)
    group:entry { item = "rubber_band", count = { 8, 20 }, probability = 60 }
    group:entry { item = "file", count = { 8, 20 }, probability = 80 }
    group:entry { item = "paper", count = { 40, 90 }, probability = 80 }
    group:entry { group = "writing_utensils", count = { 40, 100 }, probability = 80 }
    group:entry { item = "book_binder", count = { 1, 5 }, probability = 90 }
    group:entry { item = "stapler", count = { 3, 10 }, probability = 60 }
    group:entry { item = "office_holepunch", count = { 2, 10 }, probability = 35 }
    group:entry { item = "scissors", count = { 4, 10 }, probability = 35 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for an office filing cabinet containing folders and documents.
    local group = content.ItemGroup { id = "SUS_office_filing_cabinet", kind = "collection" }
    group:entry { item = "file", count = { 1, 15 }, probability = 95 }
    group:entry { item = "paper", count = { 2, 30 }, probability = 80 }
    group:item("book_binder", 80)
    group:entry {
        group = "used_memory_cards",
        count = { 1, 2 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 30,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_efiles_office", kind = "collection" }
    group:entry { group = "textbooks", count = { 1, 2 }, probability = 40 }
    group:entry { item = "efile_lore", count = { 1, 1 }, probability = 30 }
    group:entry { item = "efile_map", count = { 1, 1 }, probability = 10 }
    group:entry { item = "efile_recipes", count = { 1, 1 }, probability = 80 }
    group:entry { item = "efile_junk", count = { 6, 12 } }
    content.add(group)
end
