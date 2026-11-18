local content = require("ccb").content

do
    local group = content.ItemGroup { id = "lab_shoes", kind = "distribution" }
    group:item("sneakers", 80)
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("toecaps", 30)
    group:item("sneakers_steel", 35)
    group:item("boots_hiking", 40)
    group:item("dress_shoes", 50)
    group:item("boots_denim", 1)
    group:item("shoes_denim", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_torso", kind = "distribution" }
    group:item("coat_lab", 20)
    group:item("coat_lab", 20)
    group:item("coat_lab", 20)
    group:item("coat_lab", 20)
    group:item("tshirt", 80)
    group:item("longshirt", 80)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("denim_shirt", 20)
    group:item("dress", 70)
    group:item("sweatshirt", 75)
    group:item("sweater", 75)
    group:item("turtleneck", 25)
    group:item("turtleneck_shirt", 25)
    group:item("hoodie", 65)
    group:item("hoodie_cropped", 6)
    group:item("jumpsuit", 20)
    group:item("lanyard", 10)
    group:item("badge_doctor", 10)
    group:item("hazmat_suit", 5)
    group:item("cleansuit", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_pants", kind = "distribution" }
    group:item("jeans", 90)
    group:item("jeans_skinny", 10)
    group:item("pants_checkered", 5)
    group:item("pants", 75)
    group:item("pants_cargo", 70)
    group:item("skirt", 75)
    group:item("skirt_long", 60)
    group:item("skirt_denim", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "everyday_gear_lab", kind = "collection" }
    group:item("joint", 7)
    group:entry { item = "matches", charges = { 0, 20 }, probability = 20 }
    group:entry { item = "ref_matches", charges = { 0, 32 }, probability = 20 }
    group:group("tobacco_products", 20)
    group:entry { item = "permanent_marker", charges = { 0, -1 }, probability = 25 }
    group:group("chewing_gum_used", 30)
    group:group("chewing_gum_used_caff", 5)
    group:item("multitool", 5)
    group:group("chewing_gum_used_caff", 5)
    group:item("pocketwatch", 3)
    group:item("pockknife", 15)
    group:item("knife_folding", 15)
    group:item("knife_swissarmy", 10)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 5 }
    content.add(group)
end
