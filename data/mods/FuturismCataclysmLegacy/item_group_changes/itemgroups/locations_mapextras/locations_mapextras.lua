local content = require("ccb").content

do
    local group = content.ItemGroup { id = "drugdealer", kind = "distribution" }
    group:item("fcl_atomic_smartphone", 2)
    content.extend_item_group(group)
end
