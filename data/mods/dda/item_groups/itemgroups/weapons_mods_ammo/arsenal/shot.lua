local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_shot_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_shot_gun&mags")
    group:group("ammo_can_shot_any_full", 30)
    group:entry { group = "ammo_can_shot_any_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_shot_gun&mags", kind = "collection" }
    group:entry { group = "milspec_arsenal_shot", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_shot", count = { 1, 2 }, probability = 40 }
    group:entry { group = "milspec_arsenal_shot", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_shot", kind = "distribution" }
    group:item("m1014")
    group:item("mossberg_590", 70)
    group:item("mossberg_500", 50)
    group:group("nested_m26_mass_no_ammo", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m26_mass_no_ammo", kind = "collection" }
    group:item("m26_mass_standalone")
    group:entry { group = "m26_mass_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m26_mass_mags", kind = "distribution" }
    group:item("m26_mass_mag_3", 500)
    group:item("m26_mass_mag_5", 50)
    content.add(group)
end
