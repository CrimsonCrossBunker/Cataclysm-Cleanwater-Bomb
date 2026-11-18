local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ig_vp_frame", kind = "collection" }
    group:entry { item = "lc_steel_lump", count = { 4, 6 } }
    group:entry { item = "lc_steel_chunk", count = { 4, 6 } }
    group:entry { item = "scrap", count = { 4, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_hdframe", kind = "collection" }
    group:entry { item = "lc_steel_lump", count = { 4, 6 } }
    group:entry { item = "lc_steel_chunk", count = { 4, 6 } }
    group:entry { item = "scrap", count = { 4, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_wood_plate", kind = "collection" }
    group:entry { item = "splinter", count = { 7, 9 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_cloth", kind = "collection" }
    group:entry { item = "cotton_patchwork", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_sheet_metal", kind = "collection" }
    group:entry { item = "sheet_metal_small", count = { 2, 8 } }
    group:entry { item = "lc_steel_chunk", count = { 1, 4 } }
    group:entry { item = "scrap", count = { 8, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_steel_plate", kind = "collection" }
    group:entry { item = "lc_steel_lump", count = { 4, 7 } }
    group:entry { item = "lc_steel_chunk", count = { 5, 6 } }
    group:entry { item = "scrap", count = { 4, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ig_vp_device", kind = "collection" }
    group:item("plastic_chunk", 50)
    group:entry { item = "cable", count = { 1, 4 } }
    group:entry { item = "e_scrap", count = { 0, 2 } }
    content.add(group)
end
