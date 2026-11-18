local content = require("ccb").content

do
    local group = content.ItemGroup { id = "supplies_electronics", kind = "distribution" }
    group:item("solar_cell_v2", 5)
    group:item("solar_cell_v3", 2)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "supplies_hardware", kind = "distribution" }
    group:item("solar_cell_v2", 2)
    group:item("solar_cell_v3", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "supplies_mechanics", kind = "distribution" }
    group:item("solar_cell_v2", 2)
    group:item("solar_cell_v3", 1)
    content.extend_item_group(group)
end
