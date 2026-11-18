local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_300_sniper_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_300_sniper_gun&ammo")
    group:entry { item = "ammo_can_30_300jhp_240", count = { 1, 4 } }
    content.add(group)
end
