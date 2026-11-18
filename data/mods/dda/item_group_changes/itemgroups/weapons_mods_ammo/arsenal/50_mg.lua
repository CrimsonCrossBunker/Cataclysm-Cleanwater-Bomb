local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_50_mg_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_50_mg_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_50_50bmg_4fmj1tracer_100", count = { 1, 4 } },
            { item = "ammo_can_50_50bmg_1tracer4mk211_100", count = { 1, 4 }, probability = 1 },
        },
    }
    content.add(group)
end
