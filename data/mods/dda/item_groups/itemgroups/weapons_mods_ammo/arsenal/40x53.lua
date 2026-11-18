local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x53_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_40x53_gun&mags")
    group:group("ammo_can_belt40mm_full", 60)
    group:group("ammo_can_belt40mm_full", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x53_gun&mags", kind = "collection" }
    group:entry { item = "mark19", count = { 1, 1 }, probability = 80 }
    group:entry { item = "mark19", count = { 1, 1 }, probability = 30 }
    content.add(group)
end
