local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_sniper_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_308_sniper_gun&mags")
    group:group("ammo_can_308_any_full", 30)
    group:entry { group = "ammo_can_308_any_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_sniper_gun&mags", kind = "collection" }
    group:entry { group = "milspec_arsenal_308_sniper", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_308_sniper", count = { 1, 2 }, probability = 40 }
    group:entry { group = "milspec_arsenal_308_sniper", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_sniper", kind = "distribution" }
    group:group("nested_m110a1_no_ammo")
    group:group("nested_m14ebr_no_ammo", 70)
    group:group("nested_m24_no_ammo", 50)
    group:group("nested_scar_no_ammo", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m110a1_no_ammo", kind = "collection" }
    group:item("m110a1")
    group:entry { group = "m110a1_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m110a1_mags", kind = "distribution" }
    group:item("hk417mag_10rd", 500)
    group:item("hk417mag_20rd", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m14ebr_no_ammo", kind = "collection" }
    group:item("m14ebr")
    group:entry { group = "m14ebr_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m14ebr_mags", kind = "distribution" }
    group:item("m14mag", 500)
    group:item("m14smallmag", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m24_no_ammo", kind = "collection" }
    group:item("M24")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_scar_no_ammo", kind = "collection" }
    group:item("scar_h_mk20")
    group:entry { group = "scar_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "scar_mags", kind = "distribution" }
    group:item("scarhmag", 500)
    group:item("scarhmag_30rd", 50)
    content.add(group)
end
