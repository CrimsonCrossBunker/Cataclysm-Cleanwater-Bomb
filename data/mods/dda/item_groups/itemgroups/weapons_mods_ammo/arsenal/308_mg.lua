local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_mg_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_308_mg_gun&mags")
    group:group("ammo_can_308_mg_any_full", 30)
    group:entry { group = "ammo_can_308_mg_any_full", count = { 0, 1 }, probability = 80 }
    group:entry { group = "ammo_can_308_mg_any_part", count = { 1, 2 } }
    group:entry { group = "ammo_can_308_mg_any_part", count = { 1, 2 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_mg_gun&mags", kind = "collection" }
    group:entry { item = "m240", count = { 1, 1 } }
    group:entry { item = "m240", count = { 1, 1 }, probability = 40 }
    group:entry { item = "m240", count = { 1, 1 }, probability = 10 }
    content.add(group)
end
