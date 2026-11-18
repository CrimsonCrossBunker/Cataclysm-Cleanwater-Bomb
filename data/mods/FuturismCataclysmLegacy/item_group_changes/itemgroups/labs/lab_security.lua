local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_electromagnetic_loot", kind = "distribution" }
    group:group("fcl_SUS_heavy_rail_rifle", 60)
    content.extend_item_group(group)
end

do
    -- This group is for rare spawns of rivetech matched sets.
    local group = content.ItemGroup { id = "SUS_rivtech_loot", kind = "distribution" }
    group:group("SUS_rivtech_5x50", 30)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_rivtech_8x40_mag", kind = "distribution" }
    group:item("fcl_8x40_250_mag", 10)
    group:item("fcl_8x40_500_mag", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_rivtech_8x40_rm", kind = "distribution" }
    group:item("fcl_rm298", 30)
    group:item("fcl_rm614_lmg", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_rivtech_40mm_rm", kind = "distribution" }
    group:entry { item = "fcl_rm802", charges = { 0, 4 }, probability = 80 }
    content.extend_item_group(group)
end
