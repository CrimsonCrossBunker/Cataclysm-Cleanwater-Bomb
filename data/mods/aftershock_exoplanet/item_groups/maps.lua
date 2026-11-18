local content = require("ccb").content

do
    local group = content.ItemGroup { id = "afs_shuttle_debris", kind = "distribution" }
    group:item("scrap", 30)
    group:item("ch_steel_chunk", 20)
    group:item("afs_material_1", 10)
    group:item("sheet_metal_small", 10)
    group:item("sheet_metal", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_formless_ruins_random_loot", kind = "distribution" }
    group:group("afs_machinery_maintenance_scrapgroup", 50)
    group:group("afs_basic_material_scrapgroup", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_formless_ruins_random_suit", kind = "distribution" }
    group:group("afs_wintersuit_civilian_advanced", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_your_ship_display_case", kind = "collection" }
    group:item("afs_thi_deed")
    group:item("afs_old_ship_medal")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_your_ship_safe", kind = "collection" }
    group:item("afs_ship_ids")
    group:entry { item = "gold_small", count = { 10, 10 } }
    content.add(group)
end
