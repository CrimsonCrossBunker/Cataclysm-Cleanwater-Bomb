local content = require("ccb").content

do
    local group = content.ItemGroup { id = "robots", kind = "distribution" }
    group:item("solar_cell_v2", 2)
    group:item("solar_cell_v3", 1)
    content.extend_item_group(group)
end
