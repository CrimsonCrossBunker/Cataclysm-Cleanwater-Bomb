local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_CITY_COP_storage", kind = "distribution" }
    group:item("duffelbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_gloves", kind = "distribution" }
    group:item("gloves_leather", 45)
    group:item("gloves_medical", 20)
    group:item("gloves_tactical", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_helmet", kind = "distribution" }
    group:item("helmet_riot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants", kind = "distribution" }
    group:item("pants", 75)
    group:item("pants_cargo", 70)
    group:item("leather_belt", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes", kind = "distribution" }
    group:item("boots", 70)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("boots_hiking", 20)
    group:item("boots_western", 5)
    group:item("boots_combat", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_torso", kind = "distribution" }
    group:item("dress_shirt", 50)
    group:item("postman_shirt", 45, "sheriff")
    group:item("jacket_light", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_melee", kind = "distribution" }
    group:item("baton", 50)
    group:item("PR24-retracted", 30)
    group:item("tazer", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_weapons", kind = "distribution" }
    group:group("cop_melee")
    group:group("guns_cop")
    content.add(group)
end
