local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_9mm_gun&mags")
    group:group("ammo_can_9mm_any_full", 30)
    group:entry { group = "ammo_can_9mm_any_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm_gun&mags", kind = "collection" }
    group:entry { group = "milspec_arsenal_9mm", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_9mm", count = { 1, 2 }, probability = 40 }
    group:entry { group = "milspec_arsenal_9mm", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm", kind = "distribution" }
    group:group("nested_m9_no_ammo", 70)
    group:group("nested_m11_no_ammo", 70)
    group:group("nested_m17_no_ammo")
    group:group("nested_m18_no_ammo")
    group:group("nested_p226_no_ammo", 10)
    group:group("nested_glock_19_no_ammo", 10)
    group:group("nested_glock_17_no_ammo", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m9_no_ammo", kind = "collection" }
    group:item("m9", 100, "m9")
    group:entry { group = "m9_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m9_mags", kind = "distribution" }
    group:item("m9mag", 50)
    group:item("m9mag_10rd", 50)
    group:item("m9mag_17rd", 400)
    group:item("m9mag_18rd", 70)
    group:item("m9mag_20rd", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m11_no_ammo", kind = "collection" }
    group:item("m11")
    group:entry { item = "p228mag_13rd_9x19mm", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m17_no_ammo", kind = "collection" }
    group:item("m17")
    group:entry { group = "m17_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m17_mags", kind = "distribution" }
    group:item("p320mag_10rd_9x19mm", 50)
    group:item("p320mag_17rd_9x19mm", 400)
    group:item("p320mag_21rd_9x19mm", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_m18_no_ammo", kind = "collection" }
    group:item("m18")
    group:entry { group = "m17_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_p226_no_ammo", kind = "collection" }
    group:item("p226_9mm")
    group:entry { group = "p226_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "p226_mags", kind = "distribution" }
    group:item("p226mag_10rd_9x19mm", 400)
    group:item("p226mag_15rd_9x19mm", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_glock_19_no_ammo", kind = "collection" }
    group:item("glock_19")
    group:entry { group = "glock_19_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glock_19_mags", kind = "distribution" }
    group:item("glockmag", 50)
    group:item("glock17_17", 400)
    group:item("glock17_22", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_glock_17_no_ammo", kind = "collection" }
    group:item("glock_17")
    group:entry { group = "glock_17_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "glock_17_mags", kind = "distribution" }
    group:item("glock17_17", 400)
    group:item("glock17_22", 70)
    content.add(group)
end
