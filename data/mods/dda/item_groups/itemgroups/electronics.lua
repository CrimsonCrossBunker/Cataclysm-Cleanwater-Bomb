local content = require("ccb").content

do
    -- new_X e-devices are for brand-new or freshly issued e-devices, usually empty
    local group = content.ItemGroup { id = "new_usb_drives", kind = "distribution" }
    group:item("usb_drive")
    content.add(group)
end

do
    -- used_X e-devices are for e-devices that have previous use and should have contents
    local group = content.ItemGroup { id = "used_usb_drives", kind = "distribution" }
    group:item("usb_drive", 5)
    group:item("usb_drive_older", 1)
    content.add(group)
end

do
    -- these civilian_X e-devices are pre-loaded with general files to avoid repetition; if you want more specific contents, give used_X a contents-group in its own entry
    local group = content.ItemGroup { id = "civilian_usb_drives", kind = "distribution" }
    group:entry {
        item = "usb_drive",
        contents = {
            { group = "civilian_portable_efiles" },
        },
        probability = 5,
    }
    group:entry {
        item = "usb_drive_older",
        contents = {
            { group = "civilian_portable_efiles" },
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "new_memory_cards", kind = "distribution" }
    group:item("memory_card")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_memory_cards", kind = "distribution" }
    group:item("memory_card", 5)
    group:item("memory_card_older", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_memory_cards", kind = "distribution" }
    group:entry {
        item = "memory_card",
        contents = {
            { group = "civilian_portable_efiles" },
        },
        probability = 5,
    }
    group:entry {
        item = "memory_card",
        contents = {
            { group = "civilian_portable_efiles" },
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "new_eink_tablet_pcs", kind = "distribution" }
    group:entry { item = "eink_tablet_pc", charges = { 100, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "new_phones", kind = "distribution" }
    group:group("new_phones_case", 10)
    group:group("new_phones_no_case", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_phones", kind = "distribution" }
    group:group("civilian_phones_case", 10)
    group:group("civilian_phones_no_case", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "smart_phone_maybe_locked", kind = "distribution" }
    group:entry { item = "smart_phone", charges = { 0, 24 }, probability = 25 }
    group:entry { item = "smart_phone_locked", charges = { 0, 24 }, probability = 75 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "box_of_batteries_unopened", kind = "distribution", container = "box_paper_small" }
    group:entry { item = "light_minus_battery_cell", count = { 8, 8 }, charges = { 1000, 1000 }, probability = 3 }
    group:entry { item = "light_minus_disposable_cell", count = { 8, 8 }, charges = { 1000, 1000 }, probability = 30 }
    group:entry { item = "light_battery_cell", count = { 8, 8 }, charges = { 1000, 1000 }, probability = 160 }
    group:entry { item = "light_battery_cell", count = { 16, 16 }, charges = { 1000, 1000 }, probability = 16 }
    group:entry { item = "light_cell_rechargeable", count = { 8, 8 }, charges = { 1000, 1000 }, probability = 16 }
    group:entry { item = "light_cell_rechargeable", count = { 12, 12 }, charges = { 1000, 1000 }, probability = 1 }
    group:entry { item = "medium_battery_cell", count = { 4, 4 }, charges = { 1000, 1000 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "batteries", kind = "collection" }
    group:entry { group = "box_of_batteries_random", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soldering_tool", kind = "distribution" }
    group:item("soldering_iron")
    group:entry { item = "soldering_iron_portable", charges = { 0, 56 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "soldering_supplies", kind = "collection" }
    group:group("soldering_tool")
    group:group("solder_wire_spool_part")
    content.add(group)
end
