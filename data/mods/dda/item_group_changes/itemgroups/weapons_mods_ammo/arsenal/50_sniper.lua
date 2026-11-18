local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_50bmg_sniper_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_50bmg_sniper_gun&ammo")
    group:entry { item = "ammo_can_50_50bmg_fmj_120", count = { 1, 4 } }
    content.add(group)
end
