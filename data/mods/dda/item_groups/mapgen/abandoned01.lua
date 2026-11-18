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
