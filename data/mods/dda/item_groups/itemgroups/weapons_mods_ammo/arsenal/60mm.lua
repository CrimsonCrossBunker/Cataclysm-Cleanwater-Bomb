local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_60mm_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_60mm_gun&mags")
    group:group("ammo_can_60mm_any_full", 80)
    group:group("ammo_can_60mm_any_full", 5)
    group:entry {
        distribution = {
            { item = "ammunition_can_pa124", count = { 0, 2 }, variant = "ammunition_can_pa124_60mm_m720a1_8" },
            { item = "ammunition_can_pa124", count = { 0, 2 }, variant = "ammunition_can_pa124_60mm_m768_8" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_60mm_gun&mags", kind = "collection" }
    group:item("mortar_m224", 80)
    content.add(group)
end
