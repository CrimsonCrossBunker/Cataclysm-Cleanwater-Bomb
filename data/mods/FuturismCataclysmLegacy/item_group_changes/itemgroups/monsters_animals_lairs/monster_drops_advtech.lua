local content = require("ccb").content

do
    local group = content.ItemGroup { id = "robots", kind = "distribution" }
    group:item("solar_cell_v2", 2)
    group:item("solar_cell_v3", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "copbot", kind = "distribution" }
    group:item("baton", 8)
    group:item("tazer", 3)
    group:item("sheet_kevlar_layered", 10)
    group:item("ceramic_armor", 15)
    group:item("tonfa", 10)
    group:item("shocktonfa_off", 5)
    group:entry { item = "alloy_sheet", count = { 1, 10 }, probability = 10 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "tripod", kind = "distribution" }
    group:entry { item = "flamethrower", charges = { 0, 3000 }, probability = 1 }
    group:item("sheet_kevlar_layered", 10)
    group:item("ceramic_armor", 15)
    group:item("alloy_sheet", 10)
    group:item("robot_controls", 3)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "broken_robots", kind = "collection" }
    group:entry { item = "scrap", count = { 2, 4 } }
    group:entry { item = "ch_steel_chunk", count = { 0, 2 } }
    group:entry { item = "glass_shard", count = { 0, 2 } }
    group:item("spring", 20)
    group:item("material_aluminium_ingot", 20)
    content.upsert_item_group(group)
end
