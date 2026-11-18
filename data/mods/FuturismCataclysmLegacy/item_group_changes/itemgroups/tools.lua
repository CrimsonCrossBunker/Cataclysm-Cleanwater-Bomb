local content = require("ccb").content

do
    -- tools and equipment you might find on robotics laboratories.
    local group = content.ItemGroup { id = "tools_robotics", kind = "collection" }
    group:item("fcl_atomic_lamp", 1)
    content.extend_item_group(group)
end
