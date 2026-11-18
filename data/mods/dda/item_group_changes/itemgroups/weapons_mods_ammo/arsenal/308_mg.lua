local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_mg_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_308_mg_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_30_308_1tracer4ap_200", count = { 1, 4 } },
            { item = "ammo_can_30_308_4fmj1tracer_200", count = { 1, 4 } },
            { item = "ammo_can_50_308_600", count = { 1, 4 } },
            { item = "ammo_can_fat_50_308_1tracer4ap_600", count = { 1, 4 } },
        },
    }
    content.add(group)
end
