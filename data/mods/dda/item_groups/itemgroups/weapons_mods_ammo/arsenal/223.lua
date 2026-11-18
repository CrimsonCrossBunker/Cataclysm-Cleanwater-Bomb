local content = require("ccb").content

do
    -- only default 223 because have no info about using another one in such pouches
    local group = content.ItemGroup { id = "milspec_arsenal_223_pouch_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_223_gun&mags")
    group:group("ammo_can_223_any_full", 30)
    group:entry { group = "ammo_can_223_any_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    -- only default 223 because have no info about using another one in such pouches
    local group = content.ItemGroup { id = "milspec_arsenal_223_gun&mags", kind = "collection" }
    group:entry { group = "milspec_arsenal_223", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_223", count = { 1, 2 }, probability = 40 }
    group:entry { group = "milspec_arsenal_223", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_223", kind = "distribution" }
    group:group("nested_m4_carbine_no_ammo", 70)
    group:group("nested_h&k416a5_assault_rifle_no_ammo", 40)
    group:group("nested_m27_assault_rifle_no_ammo", 15)
    group:group("nested_m38dmr_no_ammo", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m4_carbine_no_ammo", kind = "collection" }
    group:group("modular_m4a1")
    group:entry { group = "stanag_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m27_assault_rifle_no_ammo", kind = "collection" }
    group:group("m27iar")
    group:entry { group = "stanag_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_h&k416a5_assault_rifle_no_ammo", kind = "collection" }
    group:group("h&k416a5_any")
    group:entry { group = "stanag_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m38dmr_no_ammo", kind = "collection" }
    group:group("m38dmr")
    group:entry { group = "stanag_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stanag_mags", kind = "distribution" }
    group:item("stanag30")
    group:item("stanag30ranger", 10)
    content.add(group)
end
