local content = require("ccb").content

do
    local group = content.ItemGroup { id = "foodperson_mask_loaded", kind = "collection", container = "foodperson_mask" }
    group:item("medium_battery_cell")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "foodperson_outfit", kind = "collection" }
    group:group("foodperson_mask_loaded")
    group:item("cape_fp")
    group:item("chestguard_hard")
    group:item("legguard_hard")
    group:item("armguard_hard")
    group:item("gloves_rubber")
    group:item("boots_rubber")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_foodperson", kind = "collection", container = "corpse" }
    group:group("foodperson_outfit")
    content.add(group)
end
