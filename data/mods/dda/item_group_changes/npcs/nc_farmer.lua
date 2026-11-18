local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_FARMER_pants_male", kind = "distribution" }
    group:item("jeans", 70)
    group:item("pants", 20)
    group:item("pants_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_pants_female", kind = "distribution" }
    group:item("jeans", 70)
    group:item("pants", 20)
    group:item("pants_cargo", 20)
    group:item("skirt", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_shoes", kind = "distribution" }
    group:item("boots", 90)
    group:item("boots_denim", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_shirt", kind = "distribution" }
    group:item("tshirt", 40)
    group:item("polo_shirt", 20)
    group:item("tank_top", 20)
    group:item("denim_shirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_gloves", kind = "distribution" }
    group:item("gloves_work")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_windbreaker", 10)
    group:item("jacket_leather", 20)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 60)
    group:item("vest_jean", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_storage", kind = "distribution" }
    group:item("null", 75)
    group:item("backpack", 10)
    group:item("backpack_leather", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_tools", kind = "distribution" }
    group:item("null", 25)
    group:item("shovel", 75)
    group:item("hoe", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FARMER_hat", kind = "distribution" }
    group:item("hat_ball", 10)
    group:item("hat_boonie", 10)
    group:item("null", 10)
    group:item("hat_cotton", 10)
    content.add(group)
end
