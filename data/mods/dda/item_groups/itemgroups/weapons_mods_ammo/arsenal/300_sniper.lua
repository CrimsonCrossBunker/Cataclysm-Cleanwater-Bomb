local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_300_sniper_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_300_sniper_gun&mags")
    group:group("ammo_can_300_full", 30)
    group:entry { group = "ammo_can_300_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_300_sniper_gun&mags", kind = "collection" }
    group:entry { group = "nested_m2010_no_ammo", count = { 1, 2 } }
    group:entry { group = "nested_m2010_no_ammo", count = { 1, 2 }, probability = 40 }
    group:entry { group = "nested_m2010_no_ammo", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m2010_no_ammo", kind = "collection" }
    group:item("m2010")
    group:entry { item = "m2010mag", count = { 1, 3 } }
    content.add(group)
end
