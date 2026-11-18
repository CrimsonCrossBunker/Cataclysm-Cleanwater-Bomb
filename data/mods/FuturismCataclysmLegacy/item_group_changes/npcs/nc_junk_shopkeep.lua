local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_JUNK_SHOPKEEP_misc", kind = "collection" }
    group:item("fcl_atomic_light", 1)
    group:item("fcl_atomic_lamp", 1)
    content.extend_item_group(group)
end
