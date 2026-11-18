local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_pistol_milspec", kind = "distribution" }
    group:item("fcl_5x50dart", 30)
    group:item("fcl_5x50heavy", 20)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "ammo_casings", kind = "distribution" }
    group:item("fcl_5x50_hull", 60)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "ammo_casings_milspec", kind = "distribution" }
    group:entry { item = "fcl_5x50_hull", count = { 1, 30 }, probability = 10 }
    content.extend_item_group(group)
end
