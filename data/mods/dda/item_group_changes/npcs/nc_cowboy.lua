local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_COWBOY_pants_male", kind = "distribution" }
    group:item("jeans", 70)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_pants_female", kind = "distribution" }
    group:item("jeans", 70)
    group:item("pants", 20)
    group:item("pants_leather", 20)
    group:item("pants_cargo", 20)
    group:item("skirt", 5)
    group:item("skirt_denim", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_shoes", kind = "distribution" }
    group:item("sneakers", 20)
    group:item("boots_western", 10)
    group:item("boots", 50)
    group:item("boots_denim", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_shirt", kind = "distribution" }
    group:item("tshirt", 60)
    group:item("polo_shirt", 20)
    group:item("dress_shirt", 20)
    group:item("denim_shirt", 50)
    group:item("tank_top", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_gloves", kind = "distribution" }
    group:item("null", 20)
    group:item("gloves_leather", 60)
    group:item("gloves_work", 20)
    group:item("gloves_fingerless", 20)
    group:item("fire_gauntlets", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_coat", kind = "distribution" }
    group:item("null", 20)
    group:item("hoodie", 20)
    group:item("jacket_light", 20)
    group:item("jacket_windbreaker", 10)
    group:item("jacket_leather", 20)
    group:item("trenchcoat", 20)
    group:item("jacket_jean", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_vest", kind = "distribution" }
    group:item("null", 20)
    group:item("kevlar", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_storage", kind = "distribution" }
    group:item("null", 70)
    group:item("backpack", 10)
    group:item("backpack_denim", 10)
    group:item("backpack_leather", 10)
    group:item("holster", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_holster", kind = "distribution" }
    group:item("null", 25)
    group:item("holster", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_COWBOY_hat", kind = "distribution" }
    group:item("cowboy_hat", 60)
    group:item("10gal_hat", 10)
    group:item("hat_ball", 10)
    group:item("hat_hard", 10)
    group:item("helmet_bike", 10)
    group:item("null", 10)
    group:item("helmet_motor", 10)
    group:item("hat_hunting", 10)
    group:item("hat_sombrero", 5)
    content.add(group)
end
