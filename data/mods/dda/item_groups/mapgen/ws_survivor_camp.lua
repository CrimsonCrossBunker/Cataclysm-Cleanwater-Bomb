local content = require("ccb").content

do
    local group = content.ItemGroup { id = "sc_loot_general", kind = "distribution" }
    group:item("rock", 20)
    group:item("sharp_rock", 20)
    group:item("dry_meat", 20)
    group:item("dry_veggy", 20)
    group:item("stick", 20)
    group:item("pointy_stick", 20)
    group:item("bottle_plastic", 20)
    group:item("carrot", 20)
    group:item("hotdogs_campfire", 20)
    group:item("birchbark", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sc_loot_equipment", kind = "distribution" }
    group:item("flask_hip", 20)
    group:item("shortbow", 20)
    group:entry { group = "makeshift_archery_ammo", count = { 1, 2 }, probability = 20 }
    group:item("quiver_birchbark", 30)
    group:item("fire_drill", 30)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 30 }
    group:entry { item = "matches", charges = { 0, 20 }, probability = 30 }
    group:entry { item = "small_lighter", charges = { 0, 50 }, probability = 10 }
    group:item("sunglasses", 30)
    group:item("fitover_sunglasses", 20)
    group:item("ax", 10)
    group:item("saw", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sc_loot_rare", kind = "distribution" }
    group:item("recurbow", 20)
    group:item("quiver", 20)
    group:item("book_archery", 20)
    group:item("canteen", 20)
    group:item("knife_hunting", 30)
    group:item("binoculars", 20)
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 30 }
    group:item("backpack", 30)
    group:item("backpack_leather", 30)
    group:item("e_tool", 30)
    content.add(group)
end
