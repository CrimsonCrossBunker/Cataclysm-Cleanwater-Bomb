local content = require("ccb").content

do
    local group = content.ItemGroup { id = "accessory_ring", kind = "distribution" }
    group:item("afs_titanium_ring", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "accessory_teeth", kind = "distribution" }
    group:item("afs_titanium_tooth", 25)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "clothing_watch", kind = "distribution" }
    group:item("afs_titanium_watch", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "jewelry_front", kind = "distribution" }
    group:item("afs_titanium_watch", 35)
    group:item("afs_titanium_ring", 35)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "jewelry_back", kind = "distribution" }
    group:item("afs_titanium_watch", 35)
    group:item("afs_titanium_ring", 35)
    content.extend_item_group(group)
end

do
    -- extension of vanilla itemgroups, all adding titanium
    local group = content.ItemGroup { id = "jewelry_accessories", kind = "distribution" }
    group:item("afs_titanium_watch", 35)
    group:item("afs_titanium_tooth", 35)
    group:item("afs_titanium_ring", 35)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "rings_and_things", kind = "distribution" }
    group:item("afs_titanium_watch", 35)
    group:item("afs_titanium_ring", 35)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "oa_ig_rd_metal_trash", kind = "distribution" }
    group:item("afs_titanium_frame", 5)
    group:entry { item = "afs_scrap_titanium", count = { 2, 8 }, probability = 10 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "steel_mill_foundry", kind = "distribution" }
    group:item("afs_titanium_small", 5)
    group:entry { item = "afs_scrap_titanium", count = { 1, 4 }, probability = 5 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "bikeshop_tools", kind = "distribution" }
    group:item("afs_titanium_frame", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "college_sports", kind = "distribution" }
    group:item("afs_titanium_bat", 60)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "sports", kind = "distribution" }
    group:item("afs_titanium_bat", 40)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "allsporting", kind = "distribution" }
    group:item("afs_titanium_bat", 40)
    content.extend_item_group(group)
end
