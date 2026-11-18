local content = require("ccb").content

do
    local group = content.ItemGroup { id = "stash_water", kind = "collection" }
    group:item("funnel")
    group:entry { item = "water_clean", sealed = false, container = "bottle_plastic" }
    group:entry { item = "water_clean", charges = { 7, 15 }, sealed = false, container = "jug_plastic" }
    group:entry { item = "water_clean", charges = { 150, 350 }, container = "30gal_drum" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabin_suicide_shirt", kind = "distribution" }
    group:item("hoodie", 30)
    group:item("kevlar", 10)
    group:item("longshirt", 40)
    group:item("undershirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabin_suicide_over", kind = "distribution" }
    group:item("tacvest", 20)
    group:item("jacket_light", 30)
    group:item("jacket_leather", 30)
    group:item("jacket_evac", 30)
    group:item("jacket_army", 30)
    group:item("jacket_flannel", 30)
    group:item("vest", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabin_suicide_legs", kind = "distribution" }
    group:item("jeans", 35)
    group:item("pants", 40)
    group:item("pants_cargo", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabin_suicide_shoes", kind = "distribution" }
    group:item("boots", 35)
    group:item("boots_combat", 6)
    group:item("boots_hiking", 15)
    group:item("boots_survivor", 5)
    group:item("sneakers", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabin_suicide", kind = "collection" }
    group:entry { item = "usp_45", charges = { 11, 11 }, ammo = { item = "45_acp" } }
    group:entry { item = "45_casing", charges = { 1, 1 } }
    group:item("corpse")
    group:group("underwear")
    group:group("cabin_suicide_over")
    group:group("cabin_suicide_shirt")
    group:group("cabin_suicide_legs")
    group:group("cabin_suicide_shoes")
    group:entry { group = "cabin_suicide_extras", count = { 3, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cabin_suicide_extras", kind = "distribution" }
    group:entry { item = "water_clean", charges = { 1, 5 }, container = "canteen", probability = 10 }
    group:item("3006", 25)
    group:item("45_acp", 25)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 15 }
    group:item("bandana", 10)
    group:item("cig", 5)
    group:entry { item = "cell_phone", charges = { 0, 150 }, probability = 3 }
    group:entry { group = "civilian_phones", charges = { 0, -1 }, probability = 18 }
    group:item("gloves_fingerless", 5)
    group:item("holster", 5)
    group:item("hatchet", 5)
    group:item("hat_ball", 5)
    group:item("knife_combat", 5)
    group:item("silver_locket", 5)
    group:item("mask_gas", 10)
    group:item("molotov", 5)
    group:item("matches", 25)
    group:item("mbag", 10)
    group:item("machete", 2)
    group:item("photo_album", 5)
    group:item("pipe", 5)
    group:item("poncho", 5)
    group:item("sheath", 5)
    group:item("scarf", 10)
    group:item("survivormap", 2)
    group:item("wristwatch", 15)
    content.add(group)
end
