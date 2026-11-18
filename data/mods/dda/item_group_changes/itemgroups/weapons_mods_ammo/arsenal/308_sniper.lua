local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_308_sniper_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_308_sniper_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_30_308ap_240", count = { 1, 4 } },
            { item = "ammo_can_30_308fmj_460", count = { 1, 4 } },
        },
    }
    content.add(group)
end
