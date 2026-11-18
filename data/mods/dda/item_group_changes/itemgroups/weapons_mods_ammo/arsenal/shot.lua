local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_shot_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_shot_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_50_shot_160", count = { 1, 4 } },
            { item = "ammo_can_50_beanbag_160", count = { 1, 4 } },
            { item = "ammo_can_30_shot_120", count = { 1, 4 } },
        },
    }
    content.add(group)
end
