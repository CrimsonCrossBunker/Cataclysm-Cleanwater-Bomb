local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_50bmg_sniper_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_50bmg_sniper_gun&mags")
    group:group("ammo_can_50_any_full", 30)
    group:entry { group = "ammo_can_50_any_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_50bmg_sniper_gun&mags", kind = "collection" }
    group:entry { group = "nested_m107a1_no_ammo", count = { 1, 1 } }
    group:entry { group = "nested_m107a1_no_ammo", count = { 1, 1 }, probability = 40 }
    group:entry { group = "nested_m107a1_no_ammo", count = { 1, 1 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m107a1_no_ammo", kind = "collection" }
    group:item("m107a1")
    group:entry { item = "m107a1mag", count = { 1, 3 } }
    content.add(group)
end
