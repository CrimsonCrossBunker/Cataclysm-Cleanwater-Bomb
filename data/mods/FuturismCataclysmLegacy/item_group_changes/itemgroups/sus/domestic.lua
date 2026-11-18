local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_oven", kind = "collection" }
    group:item("fcl_atompot", 3)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "SUS_coffee_cupboard", kind = "collection" }
    group:item("atomic_coffeepot", 10)
    content.extend_item_group(group)
end
