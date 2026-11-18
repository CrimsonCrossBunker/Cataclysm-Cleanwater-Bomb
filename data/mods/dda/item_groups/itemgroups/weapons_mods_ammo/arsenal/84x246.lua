local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_84x246_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_84x246_gun&mags")
    group:group("ammo_box_84x246mm_any_full", 30)
    group:entry { group = "ammo_box_84x246mm_any_full", count = { 0, 1 }, probability = 80 }
    group:entry { group = "ammo_box_84x246mm_any_full", count = { 0, 1 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_84x246_gun&mags", kind = "collection" }
    group:group("milspec_arsenal_84x246", 80)
    group:group("milspec_arsenal_84x246", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_84x246", kind = "distribution" }
    group:item("m3_carlgustav")
    group:item("m4_carlgustav", 70)
    group:entry { item = "AT4", count = { 1, 3 }, charges = { 1, 1 }, probability = 50 }
    content.add(group)
end
