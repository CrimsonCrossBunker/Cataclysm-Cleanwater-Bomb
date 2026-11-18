local content = require("ccb").content

do
    local group = content.ItemGroup { id = "military_standard_pistols", kind = "distribution" }
    group:entry { item = "fcl_needlepistol", charges = { 0, 50 }, probability = 2 }
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "helicopter", kind = "distribution" }
    group:entry { item = "fcl_needlegun", charges = { 0, 100 }, probability = 1 }
    group:entry { item = "fcl_needlepistol", charges = { 0, 50 }, probability = 1 }
    group:item("fcl_5x50dart", 2)
    group:item("fcl_5x50heavy", 1)
    group:entry { item = "fcl_rm298", charges = { 0, 250 }, probability = 1 }
    group:entry { item = "fcl_fusion_pellet", charges = { 0, 25 } }
    group:item("solar_cell_v2", 1)
    group:item("solar_cell_v3", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "military_standard_assault_rifles", kind = "distribution" }
    group:entry { item = "fcl_needlegun", charges = { 0, 100 }, probability = 2 }
    content.extend_item_group(group)
end
