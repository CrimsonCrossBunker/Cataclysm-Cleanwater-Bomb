local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_223_mg_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_223_mg_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_fat_50_223_1tracer4ball_800", count = { 1, 4 } },
            { item = "ammo_can_fat_50_223_1tracer4ap_800", count = { 1, 4 }, probability = 50 },
            { item = "ammo_can_fat_50_223ap_800", count = { 1, 4 }, probability = 40 },
            { item = "ammo_can_fat_50_223fmj_800", count = { 1, 4 }, probability = 80 },
        },
    }
    content.add(group)
end
