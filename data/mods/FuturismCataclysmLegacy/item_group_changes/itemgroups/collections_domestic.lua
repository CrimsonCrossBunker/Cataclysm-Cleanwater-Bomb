local content = require("ccb").content

do
    -- Mundane household appliances that you might find in a kitchen.
    local group = content.ItemGroup { id = "kitchen_appliances", kind = "distribution" }
    group:item("fcl_atomic_coffeemaker", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "home_hw", kind = "distribution" }
    group:item("fcl_atomic_lamp", 1)
    group:item("fcl_atomic_light", 1)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "livingroom", kind = "distribution" }
    group:item("fcl_atomic_smartphone", 1)
    group:item("fcl_atomic_lamp", 1)
    group:item("fcl_atomic_light", 1)
    content.extend_item_group(group)
end
