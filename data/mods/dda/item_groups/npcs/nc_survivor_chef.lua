local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_head", kind = "distribution" }
    group:item("hat_chef", 10)
    group:item("pot_helmet", 80)
    group:item("hat_ball", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_pants_male", kind = "distribution" }
    group:item("pants_checkered", 90)
    group:item("pants", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_pants_female", kind = "distribution" }
    group:item("pants_checkered", 90)
    group:item("jeans", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_shirt_male", kind = "distribution" }
    group:item("tshirt", 90)
    group:item("longshirt", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_shirt_female", kind = "distribution" }
    group:item("tshirt", 90)
    group:item("longshirt", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_gloves", kind = "distribution" }
    group:item("null", 80)
    group:item("gloves_leather", 10)
    group:item("gloves_fingerless", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_coat", kind = "distribution" }
    group:item("jacket_chef", 90)
    group:item("hoodie", 5)
    group:item("jacket_light", 5)
    group:item("jacket_leather", 5)
    group:item("jacket_jean", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_masks", kind = "distribution" }
    group:item("null", 80)
    group:item("bandana", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SURVIVOR_CHEF_eyes", kind = "distribution" }
    group:item("null", 80)
    group:item("sunglasses", 20)
    content.add(group)
end
