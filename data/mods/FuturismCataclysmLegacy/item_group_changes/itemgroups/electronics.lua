local content = require("ccb").content

do
    local group = content.ItemGroup { id = "electronics", kind = "distribution" }
    group:item("solar_cell_v2", 2)
    group:item("solar_cell_v3", 1)
    group:item("fcl_atomic_smartphone", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "consumer_electronics", kind = "distribution" }
    group:item("solar_cell_v2", 2)
    group:item("solar_cell_v3", 1)
    group:item("fcl_atomic_smartphone", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "box_of_batteries_random", kind = "distribution" }
    group:entry { item = "light_minus_atomic_battery_cell", count = { 0, 8 }, charges = { 1000, 1000 }, probability = 1 }
    group:entry { item = "light_atomic_battery_cell", count = { 0, 4 }, charges = { 1000, 1000 }, probability = 1 }
    group:entry { item = "medium_atomic_battery_cell", count = { 0, 3 }, charges = { 1000, 1000 }, probability = 1 }
    content.extend_item_group(group)
end
