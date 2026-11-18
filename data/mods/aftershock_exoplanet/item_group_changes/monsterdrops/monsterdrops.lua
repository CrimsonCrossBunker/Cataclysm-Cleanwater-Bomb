local content = require("ccb").content

do
    local group = content.ItemGroup { id = "tripod", kind = "distribution" }
    group:entry { item = "flamethrower", charges = { 0, 3000 }, probability = 1 }
    group:item("sheet_kevlar_layered", 10)
    group:item("ceramic_armor", 15)
    group:item("alloy_plate", 10)
    group:item("robot_controls", 3)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "chickenbot", kind = "distribution" }
    group:item("robot_controls", 5)
    group:item("ai_module", 5)
    group:item("sensor_module", 5)
    group:item("memory_module", 5)
    group:item("pathfinding_module", 5)
    group:item("identification_module", 5)
    group:item("reverse_jointed_legs", 40)
    group:item("chickenbot_chassis", 40)
    group:item("targeting_module", 5)
    group:item("gun_module", 30)
    group:item("mark19", 5)
    group:item("tazer", 5)
    group:item("m249", 5)
    group:item("storage_battery", 5)
    group:item("plut_cell", 5)
    group:item("mil_plate", 2)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "tankbot", kind = "distribution" }
    group:item("tazer", 3)
    group:entry { item = "flamethrower", charges = { 0, 3000 }, probability = 1 }
    group:item("556", 8)
    group:item("alloy_plate", 10)
    group:item("sheet_kevlar_layered", 10)
    group:item("ceramic_armor", 10)
    group:item("hard_plate", 30)
    group:item("robot_controls", 5)
    content.upsert_item_group(group)
end
