local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_40x53_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_40x53_gun&ammo")
    group:entry { item = "ammo_can_pa120_40x53_32", count = { 1, 4 } }
    content.add(group)
end
