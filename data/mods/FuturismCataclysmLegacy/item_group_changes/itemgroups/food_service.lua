local content = require("ccb").content

do
    local group = content.ItemGroup { id = "coffee_prep", kind = "distribution" }
    group:item("fcl_atomic_coffeemaker", 1)
    content.extend_item_group(group)
end
