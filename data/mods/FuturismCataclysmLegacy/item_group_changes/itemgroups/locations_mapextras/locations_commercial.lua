local content = require("ccb").content

do
    local group = content.ItemGroup { id = "arcade_prizes", kind = "distribution" }
    group:item("fcl_atomic_light", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "oa_ig_cd_lockers", kind = "distribution" }
    group:item("solar_cell_v2", 5)
    group:item("solar_cell_v3", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "oa_ig_ts_lockers", kind = "distribution" }
    group:item("solar_cell_v2", 5)
    group:item("solar_cell_v3", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "oa_ig_ts_crates", kind = "distribution" }
    group:item("solar_cell_v2", 5)
    group:item("solar_cell_v3", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "elecsto_lights", kind = "distribution" }
    group:item("fcl_atomic_light", 1)
    content.extend_item_group(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_homapl", kind = "distribution" }
    group:item("fcl_atomic_coffeemaker", 2)
    group:item("fcl_atompot", 1)
    content.extend_item_group(group)
end
