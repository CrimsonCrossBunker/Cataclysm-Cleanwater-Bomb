local content = require("ccb").content

do
    local group = content.ItemGroup { id = "archeology_tools", kind = "collection" }
    group:item("bone", 75)
    content.extend_item_group(group)
end
