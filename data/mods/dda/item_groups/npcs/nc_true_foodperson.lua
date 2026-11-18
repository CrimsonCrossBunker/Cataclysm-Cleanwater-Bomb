local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_TRUE_FOODPERSON_worn", kind = "collection" }
    group:item("foodperson_mask")
    group:item("briefs")
    group:item("socks")
    group:item("pants_cargo")
    group:item("dress_shirt")
    group:item("chestguard_hard")
    group:item("cape_fp")
    group:item("fanny")
    group:item("armguard_hard")
    group:item("legguard_hard")
    group:item("gloves_rubber")
    group:item("boots_rubber")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_TRUE_FOODPERSON_melee", kind = "distribution" }
    group:item("bat", 50)
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_TRUE_FOODPERSON_misc", kind = "collection" }
    group:item("medium_battery_cell", 90)
    group:entry { item = "foodplace_snack_bar", container = "fanny" }
    group:item("foodplace_snack_bar")
    group:item("foodplace_zero_drink")
    content.add(group)
end
