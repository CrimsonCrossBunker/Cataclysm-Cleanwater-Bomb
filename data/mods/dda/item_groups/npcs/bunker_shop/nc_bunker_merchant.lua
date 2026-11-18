local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_pants_male", kind = "distribution" }
    group:item("pants_cargo", 60)
    group:item("pants", 20)
    group:item("shorts_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_pants_female", kind = "distribution" }
    group:item("pants_cargo", 60)
    group:item("pants", 20)
    group:item("shorts_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_shoes", kind = "distribution" }
    group:item("boots_combat", 90)
    group:item("boots", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_shirt_male", kind = "distribution" }
    group:item("undershirt", 30)
    group:item("sweatshirt", 20)
    group:item("under_armor", 20)
    group:item("longshirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_shirt_female", kind = "distribution" }
    group:item("undershirt", 30)
    group:item("sweatshirt", 20)
    group:item("under_armor", 20)
    group:item("longshirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_gloves", kind = "distribution" }
    group:item("null", 20)
    group:item("gloves_tactical", 60)
    group:item("gloves_fingerless", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_coat", kind = "distribution" }
    group:item("hoodie", 50)
    group:item("kevlar", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_extra", kind = "distribution" }
    group:item("rucksack")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_hat", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_eyes", kind = "distribution" }
    group:item("null", 80)
    group:item("glasses_bal", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_masks", kind = "distribution" }
    group:item("scarf")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_sell", kind = "distribution" }
    group:group("book_military", 70)
    group:group("guns_milspec", 70)
    group:group("mil_armor", 70)
    group:group("mil_food_nodrugs", 80)
    group:group("ammo_rifle_milspec", 80)
    group:group("camping", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BUNKER_MERCHANT_misc", kind = "distribution" }
    group:group("ammo_common_boxed")
    group:group("everyday_gear")
    group:group("guns_survival")
    group:group("tools_survival")
    group:group("supplies_electronics")
    group:group("clothing_outdoor_torso")
    group:group("clothing_outdoor_pants")
    group:group("clothing_outdoor_shoes")
    group:group("drugs_soldier")
    content.add(group)
end
