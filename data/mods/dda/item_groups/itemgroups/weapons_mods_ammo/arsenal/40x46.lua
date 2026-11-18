local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x46_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_40x46_gun&ammo")
    group:entry { item = "ammunition_crate_40x46_72", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x46_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_40x46_gun&mags")
    group:group("ammo_can_40x46mm_m433_full", 30)
    group:entry { group = "ammo_can_40x46mm_m433_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x46_gun&mags", kind = "collection" }
    group:entry { group = "milspec_arsenal_40x46", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_40x46", count = { 1, 2 }, probability = 40 }
    group:entry { group = "milspec_arsenal_40x46", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x46", kind = "distribution" }
    group:item("m320")
    group:item("m79", 50)
    group:item("mgl", 5)
    content.add(group)
end
